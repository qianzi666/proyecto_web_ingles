using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;

namespace Web_TANyCHEN
{
    public partial class _4Patients : Page
    {
        protected void Page_Load(object sender, EventArgs e)


        {

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();

            if (Session["Username"] == null)
            {
                Response.Redirect("2Login.aspx");
                return;
            }

       

            if (!IsPostBack)
            {
                
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
            
            DataTable patientInfo = DatabaseHelper.GetPatientByName(name);

            if (patientInfo != null && patientInfo.Rows.Count > 0)
            {
                DataRow row = patientInfo.Rows[0];
                lblName.Text = row["Name"].ToString(); 
                lblDOB.Text = row["DOB"].ToString();   
                lblAddress.Text = row["Address"].ToString(); 
                lblMobile.Text = row["Mobile"].ToString();   

                
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
            
            Session.Clear();
            Response.Redirect("2Login.aspx");
        }
    }
}
