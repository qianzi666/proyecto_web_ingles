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
            // 手动加载 SQLite.Interop.dll 文件
            string dllPath = Server.MapPath("~/bin/x64/SQLite.Interop.dll");
            IntPtr handle = LoadLibrary(dllPath);

            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // 获取用户输入
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // 调用 DatabaseHelper 验证用户
            DataTable userTable = DatabaseHelper.GetUser(username, password);

            if (userTable != null && userTable.Rows.Count > 0)
            {
                string role = userTable.Rows[0]["Role"].ToString();
                string name = userTable.Rows[0]["Name"].ToString();

                // 登录成功，存储Session信息
                Session["Username"] = username; // 将登录的用户名存入Session
                Session["Role"] = role;          // 将用户角色存入Session

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
                // 用户名或密码无效
                Response.Write("<script>alert(' Nombre de usuario o contraseña incorrectos');</script>");
            }

        }



    }
}
