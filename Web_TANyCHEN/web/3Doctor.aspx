<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="3Doctor.aspx.cs" Inherits="Web_TANyCHEN.Doctor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Management Interface for Doctors</title>
    <style>
        .container { display: flex; }
        .left-panel, .right-panel {
            width: 50%;
            padding: 10px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 20px;
            background: white;
            border: 1px solid #ccc;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .modal.active {
            display: block;
        }
        .modal-header {
            font-weight: bold;
            margin-bottom: 10px;
        }
        .modal-actions {
            margin-top: 10px;
            text-align: right;
        }



        .btn {
            padding: 5px 10px;
            text-align: center;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            cursor: pointer;
            border: none;
            display: inline-block;
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






        /* 通用按钮样式 */
        .link-button {
           display: inline-block;
            /* padding: 8px 12px; */
            /* margin: 2px; */
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
           
            text-align: center;
            cursor: pointer;
            color: white;
            transition: background-color 0.3s, transform 0.2s ease;
            border: none;
        }

        /* 各种按钮的颜色 */
        .link-button.view {
            background-color: #4CAF50; /* 绿色 - 查看 */
        }

        .link-button.update {
            background-color: #004d99; /* 蓝色 - 更新 */
        }

        .link-button.delete {
            background-color: #f44336; /* 红色 - 删除 */
        }

        /* 鼠标悬停和点击效果 */
        .link-button:hover {
            opacity: 0.9;
            transform: scale(1.05);
        }

        .link-button:active {
            transform: scale(0.95);
        }
        /* 调整按钮容器样式 */
        .button-container {
            display: flex;
           
            gap: 10px; /* 按钮之间的间距 */
        }

        /* 调整每个按钮的宽度和布局 */
        .button-container .link-button {
            flex: 1 1 calc(50% - 10px); /* 每个按钮占据 50% 宽度，减去间距 */
            box-sizing: border-box; /* 包含内边距和边框 */
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

              <asp:Button ID="btnAddPatient" runat="server" Text="Add Patient" CssClass="btn btn-add-patient" OnClientClick="openModal('addPatientModal'); return false;" />

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
        <asp:LinkButton ID="btnViewRecords" runat="server" CommandName="ViewRecords"
            CommandArgument='<%# Eval("Id") %>' Text="View Records " CssClass="btn btn-view" />
        <asp:LinkButton ID="btnUpdatePatient" runat="server" CommandName="UpdatePatient"
            CommandArgument='<%# Eval("Id") %>' Text="Update Patient" CssClass="btn btn-update" />
        <asp:LinkButton ID="btnDeletePatient" runat="server" CommandName="DeletePatient"
            CommandArgument='<%# Eval("Id") %>' Text="Delete Patient  " CssClass="btn btn-delete" />
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

