using System;
using System.Data;
using System.Data.SQLite;

namespace Web_TANyCHEN
{
    public class DatabaseHelper
    {
        private static string GetConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["SQLiteConnection"].ConnectionString;
        }

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

        public static DataTable GetAllPatients()
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "SELECT * FROM Patients";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static DataTable SearchPatientsByName(string name)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "SELECT * FROM Patients WHERE Name LIKE @Name";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", "%" + name + "%");
                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static DataTable GetMedicalRecordsByPatientId(int patientId)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "SELECT * FROM MedicalRecords WHERE PatientId = @PatientId";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", patientId);
                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static void CreatePatient(Patient patient)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "INSERT INTO Patients (Name, DOB, Address, Mobile, PIN) VALUES (@Name, @DOB, @Address, @Mobile, @PIN)";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", patient.Name);
                    cmd.Parameters.AddWithValue("@DOB", patient.DOB);
                    cmd.Parameters.AddWithValue("@Address", patient.Address);
                    cmd.Parameters.AddWithValue("@Mobile", patient.Mobile);
                    cmd.Parameters.AddWithValue("@PIN", patient.PIN);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static void UpdatePatient(Patient patient)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "UPDATE Patients SET Name = @Name, DOB = @DOB, Address = @Address, Mobile = @Mobile, PIN = @PIN WHERE Id = @Id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", patient.Name);
                    cmd.Parameters.AddWithValue("@DOB", patient.DOB);
                    cmd.Parameters.AddWithValue("@Address", patient.Address);
                    cmd.Parameters.AddWithValue("@Mobile", patient.Mobile);
                    cmd.Parameters.AddWithValue("@PIN", patient.PIN);
                    cmd.Parameters.AddWithValue("@Id", patient.Id);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static void DeletePatient(int patientId)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();

                // 开启事务，确保操作的原子性
                using (SQLiteTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // 删除患者的医疗记录
                        string deleteRecordsQuery = "DELETE FROM MedicalRecords WHERE PatientId = @PatientId";
                        using (SQLiteCommand deleteRecordsCmd = new SQLiteCommand(deleteRecordsQuery, conn, transaction))
                        {
                            deleteRecordsCmd.Parameters.AddWithValue("@PatientId", patientId);
                            deleteRecordsCmd.ExecuteNonQuery();
                        }

                        // 删除患者
                        string deletePatientQuery = "DELETE FROM Patients WHERE Id = @PatientId";
                        using (SQLiteCommand deletePatientCmd = new SQLiteCommand(deletePatientQuery, conn, transaction))
                        {
                            deletePatientCmd.Parameters.AddWithValue("@PatientId", patientId);
                            deletePatientCmd.ExecuteNonQuery();
                        }

                        // 提交事务
                        transaction.Commit();
                    }
                    catch (Exception)
                    {
                        // 回滚事务
                        transaction.Rollback();
                        throw; // 抛出异常供调用方处理
                    }
                }
            }
        }


        public static void CreateMedicalRecord(MedicalRecord record)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "INSERT INTO MedicalRecords (PatientId, AppointmentDate, Diagnosis, Treatment) VALUES (@PatientId, @AppointmentDate, @Diagnosis, @Treatment)";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@PatientId", record.PatientId);
                    cmd.Parameters.AddWithValue("@AppointmentDate", record.AppointmentDate);
                    cmd.Parameters.AddWithValue("@Diagnosis", record.Diagnosis);
                    cmd.Parameters.AddWithValue("@Treatment", record.Treatment);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static void UpdateMedicalRecord(MedicalRecord record)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "UPDATE MedicalRecords SET AppointmentDate = @AppointmentDate, Diagnosis = @Diagnosis, Treatment = @Treatment WHERE Id = @Id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AppointmentDate", record.AppointmentDate);
                    cmd.Parameters.AddWithValue("@Diagnosis", record.Diagnosis);
                    cmd.Parameters.AddWithValue("@Treatment", record.Treatment);
                    cmd.Parameters.AddWithValue("@Id", record.Id);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static void DeleteMedicalRecord(int recordId)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "DELETE FROM MedicalRecords WHERE Id = @Id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", recordId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static Patient GetPatientById(int patientId)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "SELECT * FROM Patients WHERE Id = @Id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", patientId);
                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            return new Patient
                            {
                                Id = Convert.ToInt32(row["Id"]),
                                Name = row["Name"].ToString(),
                                DOB = row["DOB"].ToString(),
                                Address = row["Address"].ToString(),
                                Mobile = row["Mobile"].ToString(),
                                PIN = row["PIN"].ToString()
                            };
                        }
                        return null;
                    }
                }
            }
        }

        public static MedicalRecord GetMedicalRecordById(int recordId)
        {
            using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
            {
                conn.Open();
                string query = "SELECT * FROM MedicalRecords WHERE Id = @Id";
                using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", recordId);
                    using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            return new MedicalRecord
                            {
                                Id = Convert.ToInt32(row["Id"]),
                                PatientId = Convert.ToInt32(row["PatientId"]),
                                AppointmentDate = row["AppointmentDate"].ToString(),
                                Diagnosis = row["Diagnosis"].ToString(),
                                Treatment = row["Treatment"].ToString()
                            };
                        }
                        return null;
                    }
                }
            }
        }
    }
}