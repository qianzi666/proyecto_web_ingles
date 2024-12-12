<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="3Doctor.aspx.cs" Inherits="Web_TANyCHEN.Doctor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Management Interface for Doctors</title>
    <style>
        .btn {
                justify-content: center;
    align-items: center;
    display: flex
;
    max-height: 55px;
    flex: 1 1 calc(50% - 10px);
    box-sizing: border-box;
    padding: 10px;
    text-align: center;
    border-radius: 4px;
    text-decoration: none;
    font-size: 14px;
    color: white;
    border: none;
        }

        .btn-view {
            background-color: #4CAF50; /* Green */
        }

        .btn-update {
            background-color: #2196F3; /* Blue */
        }

        .btn-delete {
            background-color: #f44336; /* Red */
        }

        .btn:hover {
            opacity: 0.9;
        }

        .btn-add-patient {
            padding: 10px 12px;
            background-color: #004d99;
            color: white;
            /* font-size: 16px; */
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: inline-block;
            text-align: center;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-add-patient:hover {
            background-color: #45a049; /* Slightly darker green */
            transform: scale(1.05); /* Add a hover effect */
        }

        .btn-add-patient:active {
            background-color: #3e8e41; /* Even darker green when clicked */
            transform: scale(0.95); /* Add a pressed effect */
        }

    </style>
    <script>
        function openModal(modalId) {
            document.getElementById(modalId).classList.add('active');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }
    </script>
    <link rel="stylesheet" href="doctor.css">

    <link rel="stylesheet" href="inicio.css">
</head>
<body>
        <header>
        <div class="logo">Medical Center - Doctor Management</div>
        <nav>
            <ul>
                <li><a href="2Login.aspx">Logout</a></li>
            </ul>
        </nav>
    </header>
    <form id="form1" runat="server">
        <h2>Management Interface for Doctors</h2>

        <!-- 搜索患者部分 -->
        <div class="form-group">
            <label for="txtSearchKeyword">Search Patients:</label>
            <asp:TextBox ID="txtSearchKeyword" runat="server" Placeholder="Enter Name  "></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="BtnSearch_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        </div>

        <hr />

        <div class="container">
            <!-- 左侧患者列表 -->
            <div class="left-panel">
                <h3>Patient List</h3>
                <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False"
                    AllowPaging="True" PageSize="10" DataKeyNames="Id" OnRowCommand="GvPatients_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="DOB" HeaderText="Date of Birth " />
                        <asp:BoundField DataField="Address" HeaderText="Address" />
                        <asp:BoundField DataField="Mobile" HeaderText="Phone Number " />
                        <asp:BoundField DataField="PIN" HeaderText="PIN Code" />
                        <asp:TemplateField>
                            <ItemTemplate>
                               <div class="button-container">
                                <asp:LinkButton ID="btnViewRecords" runat="server" CommandName="ViewRecords"
                                    CommandArgument='<%# Eval("Id") %>' Text="View Records" CssClass="link-button view" />
                                <asp:LinkButton ID="btnUpdatePatient" runat="server" CommandName="UpdatePatient"
                                    CommandArgument='<%# Eval("Id") %>' Text="Update Patient" CssClass="link-button update" />
                                <asp:LinkButton ID="btnDeletePatient" runat="server" CommandName="DeletePatient"
                                    CommandArgument='<%# Eval("Id") %>' Text="Delete Patient" CssClass="link-button delete" />
                            </div>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

             <asp:Button ID="btnAddPatient" runat="server" Text="Add Patient" CssClass="btn btn-add-patient" OnClick="btnOpenAddPatientModal_Click" />


            </div>

            <!-- 右侧医疗记录 -->
            <div class="right-panel">
                <h3>Medical History</h3>
               <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="False" OnRowCommand="GvMedicalRecords_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Record ID" />
                    <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment Date " />
                    <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis " />
                    <asp:BoundField DataField="Treatment" HeaderText="Treatment" />
                    <asp:TemplateField>
                     <ItemTemplate>
                          <div style="display: flex; gap: 10px;">
                        <!-- 更新记录 -->
                        <asp:LinkButton ID="btnUpdateRecord" runat="server" CommandName="UpdateRecord"
                            CommandArgument='<%# Eval("Id") %>' Text="Update Record" CssClass="btn btn-view" />
                        <!-- 删除记录 -->
                        <asp:LinkButton ID="btnDeleteRecord" runat="server" CommandName="DeleteRecord"
                            CommandArgument='<%# Eval("Id") %>' Text="Deleting Records" CssClass="btn btn-delete" />
                          </div>
                    </ItemTemplate>

                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- 添加医疗记录按钮 -->
            <asp:Button ID="btnAddMedicalRecord" runat="server" Text="Add Record  " CssClass="btn btn-add-patient" OnClientClick="openModal('addRecordModal'); return false;" />

            </div>
        </div>
        <asp:HiddenField ID="hfSelectedPatientId" runat="server" />
        <asp:HiddenField ID="hfSelectedRecordId" runat="server" />

        <!-- 添加患者弹窗 -->
        <div id="addPatientModal" class="modal">
            <div class="modal-header">Add Patient  </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientName" runat="server" Placeholder="Name "></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientDOB" runat="server" Placeholder="Date of Birth  "></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientAddress" runat="server" Placeholder="Address"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientMobile" runat="server" Placeholder="Mobile Phone Number"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientPIN" runat="server" Placeholder="PIN Code"></asp:TextBox>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnModalAddPatient" runat="server" Text="Send" OnClick="BtnAddPatient_Click" />
                <button type="button" onclick="closeModal('addPatientModal')">Cancel</button>
            </div>
        </div>

        <!-- 添加医疗记录弹窗 -->
        <div id="addRecordModal" class="modal">
            <div class="modal-header">Add Medical History</div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordDate" runat="server" Placeholder="Appointment Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordDiagnosis" runat="server" Placeholder="Diagnosis "></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordTreatment" runat="server" Placeholder="Treatment "></asp:TextBox>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnModalAddRecord" runat="server" Text="Send" OnClick="BtnAddMedicalRecord_Click" />
                <button type="button" onclick="closeModal('addRecordModal')">Cancel</button>
            </div>
        </div>
    </form>
</body>
</html>

