using System;
using System.Collections.Generic;

using System.Web;
using System.Data;
using System.Data.SQLite;
using System.Configuration;


namespace Web_TANyCHEN
{


    public class DatabaseHelper
    {
        // 获取连接字符串
        private static string GetConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["SQLiteConnection"].ConnectionString;
        }

        // 示例方法：根据用户名和密码获取用户
        public static DataTable GetUser(string username, string password)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "SELECT * FROM Users WHERE Username = @Username AND Password = @Password";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }

}