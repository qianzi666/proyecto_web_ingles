<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="2Login.aspx.cs" Inherits="Web_TANyCHEN.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>登录</h2>
        <label>用户名:</label>
        <asp:TextBox ID="txtUsername" runat="server" Placeholder="用户名"></asp:TextBox><br />
        <label>密码:</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="密码"></asp:TextBox><br />
        <asp:Button ID="btnLogin" runat="server" Text="登录" OnClick="btnLogin_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label> <!-- 显示错误消息 -->
    </form>
</body>
</html>
