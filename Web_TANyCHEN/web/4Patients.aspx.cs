using System;
using System.Data;
using System.Web.UI;

namespace Web_TANyCHEN
{
    public partial class _4Patients : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 从 QueryString 获取 Name
                string name = Request.QueryString["Name"];

                if (string.IsNullOrEmpty(name))
                {
                    Response.Redirect("2Login.aspx");
                }
                else
                {
                    BindPatientInfo(name);
                }
            }
        }

        private void BindPatientInfo(string name)
        {
            // 根据 Name 获取患者信息
            DataTable patientInfo = DatabaseHelper.GetPatientByName(name);

            if (patientInfo != null && patientInfo.Rows.Count > 0)
            {
                DataRow row = patientInfo.Rows[0];
                lblName.Text = row["Name"].ToString(); // 仅显示姓名
                lblDOB.Text = row["DOB"].ToString();   // 仅显示出生日期
                lblAddress.Text = row["Address"].ToString(); // 仅显示地址
                lblMobile.Text = row["Mobile"].ToString();   // 仅显示手机号

                // 根据 PatientId 获取医疗记录
                int patientId = Convert.ToInt32(row["Id"]);
                BindMedicalRecords(patientId);
            }
            else
            {
                lblError.Text = "Patient information not found. ";
            }
        }

        private void BindMedicalRecords(int patientId)
        {
            // 获取患者的医疗记录
            DataTable records = DatabaseHelper.GetMedicalRecordsByPatientId(patientId);

            if (records != null && records.Rows.Count > 0)
            {
                gvMedicalRecords.DataSource = records;
                gvMedicalRecords.DataBind();
            }
            else
            {
                gvMedicalRecords.DataSource = null;
                gvMedicalRecords.DataBind();
                lblError.Text += " No medical records available.  .";
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            // 清除会话信息并返回登录页面
            Session.Clear();
            Response.Redirect("2Login.aspx");
        }
    }
}
