using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using Web_TANyCHEN;

namespace Web_TANyCHEN
{
    public partial class Doctor : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPatients();
                gvMedicalRecords.DataSource = new List<MedicalRecord>();
                gvMedicalRecords.DataBind();
            }
        }

        private void BindPatients(List<Patient> data = null)
        {
            if (data == null)
            {
                DataTable dt = DatabaseHelper.GetAllPatients();
                data = ConvertToPatientList(dt);
            }

            gvPatients.DataSource = data;
            gvPatients.DataBind();
        }



        private void ShowMedicalRecords(int patientId)
        {
            DataTable dt = DatabaseHelper.GetMedicalRecordsByPatientId(patientId);
            List<MedicalRecord> records = ConvertToMedicalRecordList(dt);
            gvMedicalRecords.DataSource = records;
            gvMedicalRecords.DataBind();
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearchKeyword.Text.Trim();
            DataTable dt = DatabaseHelper.SearchPatientsByName(keyword);
            List<Patient> result = ConvertToPatientList(dt);
            BindPatients(result);
        }

        protected void GvPatients_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int patientId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewRecords")
            {
                ShowMedicalRecords(patientId);
                hfSelectedPatientId.Value = patientId.ToString();
            }
            else if (e.CommandName == "UpdatePatient")
            {
                Patient patient = DatabaseHelper.GetPatientById(patientId);
                txtModalPatientName.Text = patient.Name;
                txtModalPatientDOB.Text = patient.DOB;
                txtModalPatientAddress.Text = patient.Address;
                txtModalPatientMobile.Text = patient.Mobile;
                txtModalPatientPIN.Text = patient.PIN;
                hfSelectedPatientId.Value = patientId.ToString();
                openModal("addPatientModal");
            }
            else if (e.CommandName == "DeletePatient")
            {
                // 删除患者和其相关的医疗记录
                DatabaseHelper.DeletePatient(patientId);
                BindPatients();
            }
        }


        protected void GvMedicalRecords_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument != null && int.TryParse(e.CommandArgument.ToString(), out int recordId))
            {
                if (e.CommandName == "UpdateRecord")
                {
                    MedicalRecord record = DatabaseHelper.GetMedicalRecordById(recordId);
                    if (record != null)
                    {
                        txtModalRecordDate.Text = record.AppointmentDate;
                        txtModalRecordDiagnosis.Text = record.Diagnosis;
                        txtModalRecordTreatment.Text = record.Treatment;
                        hfSelectedRecordId.Value = recordId.ToString();
                        openModal("addRecordModal");
                    }
                }
                else if (e.CommandName == "DeleteRecord")
                {
                    DatabaseHelper.DeleteMedicalRecord(recordId);

                    // 刷新医疗记录
                    if (int.TryParse(hfSelectedPatientId.Value, out int patientId))
                    {
                        ShowMedicalRecords(patientId);
                    }
                }
            }
        }

        protected void BtnAddMedicalRecord_Click(object sender, EventArgs e)
        {
            int patientId = Convert.ToInt32(hfSelectedPatientId.Value);
            MedicalRecord newRecord = new MedicalRecord
            {
                PatientId = patientId,
                AppointmentDate = txtModalRecordDate.Text.Trim(),
                Diagnosis = txtModalRecordDiagnosis.Text.Trim(),
                Treatment = txtModalRecordTreatment.Text.Trim()
            };

            if (string.IsNullOrEmpty(hfSelectedRecordId.Value))
            {
                DatabaseHelper.CreateMedicalRecord(newRecord);
            }
            else
            {
                newRecord.Id = Convert.ToInt32(hfSelectedRecordId.Value);
                DatabaseHelper.UpdateMedicalRecord(newRecord);
                hfSelectedRecordId.Value = string.Empty;
            }

            ShowMedicalRecords(patientId);
            closeModal("addRecordModal");
        }


        protected void BtnAddPatient_Click(object sender, EventArgs e)
        {
            Patient newPatient = new Patient
            {
                Name = txtModalPatientName.Text.Trim(),
                DOB = txtModalPatientDOB.Text.Trim(),
                Address = txtModalPatientAddress.Text.Trim(),
                Mobile = txtModalPatientMobile.Text.Trim(),
                PIN = txtModalPatientPIN.Text.Trim()
            };

            // 新增患者时不需要检查 hfSelectedPatientId.Value
            if (string.IsNullOrEmpty(hfSelectedPatientId.Value))
            {
                DatabaseHelper.CreatePatient(newPatient);
            }
            else
            {
                newPatient.Id = Convert.ToInt32(hfSelectedPatientId.Value);
                DatabaseHelper.UpdatePatient(newPatient);
                hfSelectedPatientId.Value = string.Empty; // 清空选中的患者 ID
            }

            BindPatients(); // 重新绑定列表
            closeModal("addPatientModal");
        }


       

        private List<Patient> ConvertToPatientList(DataTable dt)
        {
            List<Patient> patients = new List<Patient>();
            foreach (DataRow row in dt.Rows)
            {
                Patient p = new Patient
                {
                    Id = Convert.ToInt32(row["Id"]),
                    Name = row["Name"].ToString(),
                    DOB = row["DOB"].ToString(),
                    Address = row["Address"].ToString(),
                    Mobile = row["Mobile"].ToString(),
                    PIN = row["PIN"].ToString()
                };
                patients.Add(p);
            }
            return patients;
        }

        private List<MedicalRecord> ConvertToMedicalRecordList(DataTable dt)
        {
            List<MedicalRecord> records = new List<MedicalRecord>();
            foreach (DataRow row in dt.Rows)
            {
                MedicalRecord r = new MedicalRecord
                {
                    Id = Convert.ToInt32(row["Id"]),
                    PatientId = Convert.ToInt32(row["PatientId"]),
                    AppointmentDate = row["AppointmentDate"].ToString(),
                    Diagnosis = row["Diagnosis"].ToString(),
                    Treatment = row["Treatment"].ToString()
                };
                records.Add(r);
            }
            return records;
        }

        private void openModal(string modalId)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", $"openModal('{modalId}');", true);
        }

        private void closeModal(string modalId)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "closeModal", $"closeModal('{modalId}');", true);
        }
    }
}
