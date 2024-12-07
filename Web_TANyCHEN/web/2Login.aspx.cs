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

            if (handle == IntPtr.Zero)
            {
                int errorCode = Marshal.GetLastWin32Error();
                Response.Write($"<script>alert('加载 SQLite.Interop.dll 失败，错误代码: {errorCode}');</script>");
            }
            else
            {
                Response.Write($"<script>alert('加载 SQLite.Interop.dll 成功');</script>");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // 获取用户输入
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // 调用 DatabaseHelper 检查用户
            DataTable userTable = DatabaseHelper.GetUser(username, password);

            if (userTable != null && userTable.Rows.Count > 0)
            {
                // 获取用户角色
                string role = userTable.Rows[0]["Role"].ToString();

                // 根据角色跳转
                if (role == "doctor")
                {
                    Response.Redirect("3Doctor.aspx");
                }
                else if (role == "patient")
                {
                    Response.Redirect("4Patient.aspx");
                }
                else
                {
                    Response.Write("<script>alert('未识别的用户角色');</script>");
                }
            }
            else
            {
                // 用户名或密码错误
                Response.Write("<script>alert('用户名或密码错误');</script>");
            }
        }
    }
}
