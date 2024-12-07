using System;
using System.Data;

namespace Web_TANyCHEN
{
    public partial class Doctor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPatientData();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string birthDate = txtBirthDate.Text;

            // 保存患者信息的逻辑（例如：插入到数据库）
            // 示例代码，实际应与数据库交互
            DataTable dt = (DataTable)Session["Patients"];
            if (dt == null)
            {
                dt = new DataTable();
                dt.Columns.Add("姓名");
                dt.Columns.Add("出生日期");
            }

            DataRow row = dt.NewRow();
            row["姓名"] = name;
            row["出生日期"] = birthDate;
            dt.Rows.Add(row);

            Session["Patients"] = dt;

            // 保存后重新绑定数据以刷新 GridView
            BindPatientData();
        }

        private void BindPatientData()
        {
            // 从数据库中获取患者数据并绑定到 GridView
            // 这里使用会话中的数据表作为示例
            DataTable dt = (DataTable)Session["Patients"];
            if (dt != null)
            {
                gvPatients.DataSource = dt;
                gvPatients.DataBind();
            }
        }
    }
}
