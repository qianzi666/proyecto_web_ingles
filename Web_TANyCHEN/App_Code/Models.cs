namespace Web_TANyCHEN
{
    public partial class Patient
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string DOB { get; set; }
        public string Address { get; set; }
        public string Mobile { get; set; }
        public string PIN { get; set; }
    }

    public partial class MedicalRecord
    {
        public int Id { get; set; }
        public int PatientId { get; set; }
        public string AppointmentDate { get; set; }
        public string Diagnosis { get; set; }
        public string Treatment { get; set; }
        public string PatientName { get; set; } // 添加患者姓名
    }

}
