<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="4Patients.aspx.cs" Inherits="Web_TANyCHEN._4Patients" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>患者页面</title>
    <style>
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .header {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        .section {
            margin-bottom: 20px;
        }
        .section h3 {
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .actions {
            text-align: right;
            margin-top: 20px;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">患者信息</div>

            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

            <!-- 患者基本信息部分 -->
            <div class="section">
                <h3>基本信息</h3>
                <asp:Label ID="lblName" runat="server" Text="姓名: "></asp:Label><br />
                <asp:Label ID="lblDOB" runat="server" Text="出生日期: "></asp:Label><br />
                <asp:Label ID="lblAddress" runat="server" Text="地址: "></asp:Label><br />
                <asp:Label ID="lblMobile" runat="server" Text="手机号: "></asp:Label>
            </div>

            <!-- 医疗记录部分 -->
            <div class="section">
                <h3>医疗记录</h3>
                <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="AppointmentDate" HeaderText="预约日期" />
                        <asp:BoundField DataField="Diagnosis" HeaderText="诊断" />
                        <asp:BoundField DataField="Treatment" HeaderText="治疗方案" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- 返回按钮 -->
            <div class="actions">
                <asp:Button ID="btnLogout" runat="server" Text="退出登录" OnClick="BtnLogout_Click" />
            </div>
        </div>
    </form>
</body>
</html>
