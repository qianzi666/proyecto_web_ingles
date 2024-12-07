using System;
using System.Data;

namespace Web_TANyCHEN
{
    public partial class Patient : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 从 QueryString 中获取患者信息
                string patientName = Request.QueryString["PatientName"];
                int patientId = Convert.ToInt32(Request.QueryString["PatientId"]);

                if (!string.IsNullOrEmpty(patientName) && patientId > 0)
                {
                    lblPatientName.Text = $"欢迎, {patientName}";
                    ShowPatientInfo(patientId);
                    BindPatientMedicalRecords(patientId);
                }
            }
        }

        private void ShowPatientInfo(int patientId)
        {
            // 从数据库获取患者个人信息
            Patient patient = DatabaseHelper.GetPatientById(patientId);

            if (patient != null)
            {
                lblPatientInfo.Text = $"姓名: {patient.Name}<br>出生日期: {patient.DOB}<br>" +
                                      $"地址: {patient.Address}<br>手机号: {patient.Mobile}<br>PIN: {patient.PIN}";
            }
        }

        private void BindPatientMedicalRecords(int patientId)
        {
            // 从数据库获取患者医疗记录
            DataTable records = DatabaseHelper.GetMedicalRecordsByPatientId(patientId);
            gvMedicalRecords.DataSource = records;
            gvMedicalRecords.DataBind();
        }
    }
}
