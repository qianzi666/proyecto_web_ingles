<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="3Doctor.aspx.cs" Inherits="Web_TANyCHEN.Doctor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>医生管理界面</title>
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
        <div class="logo">医疗中心 - 医生管理</div>
        <nav>
            <ul>
                <li><a href="2Login.aspx">退出登录</a></li>
            </ul>
        </nav>
    </header>
    <form id="form1" runat="server">
        <h2>医生管理界面</h2>

        <!-- 搜索患者部分 -->
        <div class="form-group">
            <label for="txtSearchKeyword">搜索患者：</label>
            <asp:TextBox ID="txtSearchKeyword" runat="server" Placeholder="输入姓名"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="搜索" OnClick="BtnSearch_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        </div>

        <hr />

        <div class="container">
            <!-- 左侧患者列表 -->
            <div class="left-panel">
                <h3>患者列表</h3>
                <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False"
                    AllowPaging="True" PageSize="10" DataKeyNames="Id" OnRowCommand="GvPatients_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Name" HeaderText="姓名" />
                        <asp:BoundField DataField="DOB" HeaderText="出生日期" />
                        <asp:BoundField DataField="Address" HeaderText="地址" />
                        <asp:BoundField DataField="Mobile" HeaderText="手机号" />
                        <asp:BoundField DataField="PIN" HeaderText="PIN码" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="btnViewRecords" runat="server" CommandName="ViewRecords"
                                    CommandArgument='<%# Eval("Id") %>' Text="查看记录" />
                                <asp:LinkButton ID="btnUpdatePatient" runat="server" CommandName="UpdatePatient"
                                    CommandArgument='<%# Eval("Id") %>' Text="更新患者" />
                                <asp:LinkButton ID="btnDeletePatient" runat="server" CommandName="DeletePatient"
                                    CommandArgument='<%# Eval("Id") %>' Text="删除患者" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:Button ID="btnAddPatient" runat="server" Text="添加患者" OnClientClick="openModal('addPatientModal'); return false;" />
            </div>

            <!-- 右侧医疗记录 -->
            <div class="right-panel">
                <h3>医疗记录</h3>
               <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="False" OnRowCommand="GvMedicalRecords_RowCommand">
    <Columns>
        <asp:BoundField DataField="Id" HeaderText="记录ID" />
        <asp:BoundField DataField="AppointmentDate" HeaderText="预约日期" />
        <asp:BoundField DataField="Diagnosis" HeaderText="诊断" />
        <asp:BoundField DataField="Treatment" HeaderText="治疗方案" />
        <asp:TemplateField>
            <ItemTemplate>
                <!-- 更新记录 -->
                <asp:LinkButton ID="btnUpdateRecord" runat="server" CommandName="UpdateRecord"
                    CommandArgument='<%# Eval("Id") %>' Text="更新记录" />
                <!-- 删除记录 -->
                <asp:LinkButton ID="btnDeleteRecord" runat="server" CommandName="DeleteRecord"
                    CommandArgument='<%# Eval("Id") %>' Text="删除记录" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<!-- 添加医疗记录按钮 -->
<asp:Button ID="btnAddMedicalRecord" runat="server" Text="添加记录" OnClientClick="openModal('addRecordModal'); return false;" />

            </div>
        </div>
        <asp:HiddenField ID="hfSelectedPatientId" runat="server" />
<asp:HiddenField ID="hfSelectedRecordId" runat="server" />

        <!-- 添加患者弹窗 -->
        <div id="addPatientModal" class="modal">
            <div class="modal-header">添加患者</div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientName" runat="server" Placeholder="姓名"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientDOB" runat="server" Placeholder="出生日期"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientAddress" runat="server" Placeholder="地址"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientMobile" runat="server" Placeholder="手机号"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientPIN" runat="server" Placeholder="PIN码"></asp:TextBox>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnModalAddPatient" runat="server" Text="提交" OnClick="BtnAddPatient_Click" />
                <button type="button" onclick="closeModal('addPatientModal')">取消</button>
            </div>
        </div>

        <!-- 添加医疗记录弹窗 -->
        <div id="addRecordModal" class="modal">
            <div class="modal-header">添加医疗记录</div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordDate" runat="server" Placeholder="预约日期"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordDiagnosis" runat="server" Placeholder="诊断"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordTreatment" runat="server" Placeholder="治疗方案"></asp:TextBox>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnModalAddRecord" runat="server" Text="提交" OnClick="BtnAddMedicalRecord_Click" />
                <button type="button" onclick="closeModal('addRecordModal')">取消</button>
            </div>
        </div>
    </form>
</body>
</html>

