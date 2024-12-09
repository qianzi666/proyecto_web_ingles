<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="2Login.aspx.cs" Inherits="Web_TANyCHEN.Login" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录页面</title>
    <link rel="stylesheet" href="stylesheet1.css">
     <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="inicio.css">
</head>
<body>
    <header>
        <div class="logo">医疗中心</div>
        <nav>
            <ul>
                <li><a href="1Index.aspx">主页</a></li>
                <li><a href="#about">关于我们</a></li>
                <li><a href="#services">服务</a></li>
                <li><a href="#contact">联系我们</a></li>
                <li><a href="2Login.aspx" class="login-btn">登录</a></li>
            </ul>
        </nav>
    </header>

    <main>
    <form id="form1" runat="server">
        <h2>登录</h2>
        <label>用户名:</label>
        <asp:TextBox ID="txtUsername" runat="server" Placeholder="用户名"></asp:TextBox><br />
        <label>密码:</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="密码"></asp:TextBox><br />
        <asp:Button ID="btnLogin" runat="server" Text="登录" OnClick="btnLogin_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label> <!-- 显示错误消息 -->
    </form>
    </main>

    <footer>
        <p>© 2024 医疗中心 - 保留所有权利</p>
    </footer>
</body>
</html>
