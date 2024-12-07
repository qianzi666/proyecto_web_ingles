<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="3Doctor.aspx.cs" Inherits="Web_TANyCHEN.Doctor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>医生管理界面</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>医生管理界面</h2>
        <div>
            <label>新增患者:</label><br />
            <asp:TextBox ID="txtName" runat="server" Placeholder="姓名"></asp:TextBox><br />
            <asp:TextBox ID="txtBirthDate" runat="server" Placeholder="出生日期"></asp:TextBox><br />
            <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" />
        </div>
        <hr />
        <h3>患者列表</h3>
        <asp:GridView ID="gvPatients" runat="server"></asp:GridView>
    </form>
</body>
</html>
