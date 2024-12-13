using System;
using System.Data;
using System.Data.SQLite;
using System.Runtime.InteropServices;
using Web_TANyCHEN;

namespace Web_TANyCHEN
{
    public partial class Login : System.Web.UI.Page
    {
        [DllImport("kernel32", SetLastError = true, CharSet = CharSet.Auto)]
        private static extern IntPtr LoadLibrary(string lpFileName);

        protected void Page_Load(object sender, EventArgs e)
        {
            
            string dllPath = Server.MapPath("~/bin/x64/SQLite.Interop.dll");
            IntPtr handle = LoadLibrary(dllPath);

            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
           
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            
            DataTable userTable = DatabaseHelper.GetUser(username, password);

            if (userTable != null && userTable.Rows.Count > 0)
            {
                string role = userTable.Rows[0]["Role"].ToString();
                string name = userTable.Rows[0]["Name"].ToString();

               
                Session["Username"] = username; 
                Session["Role"] = role;          

                if (role == "doctor")
                {
                    Response.Redirect("3Doctor.aspx");
                }
                else if (role == "patient")
                {
                    Response.Redirect($"4Patients.aspx?Name={name}");
                }
                else
                {
                    Response.Write("<script>alert('Rol de usuario no reconocido');</script>");
                }
            }
            else
            {
                
                Response.Write("<script>alert(' Nombre de usuario o contraseña incorrectos');</script>");
            }

        }



    }
}
