<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="4Patient.aspx.cs" Inherits="Web_TANyCHEN.Patient" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>患者页面</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>患者页面</h2>
        <asp:Label ID="lblPatientName" runat="server" Font-Bold="True"></asp:Label>
        <hr />
        <h3>个人信息</h3>
        <asp:Label ID="lblPatientInfo" runat="server"></asp:Label>
        <hr />
        <h3>医疗记录</h3>
        <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="True"></asp:GridView>
    </form>
</body>
</html>
