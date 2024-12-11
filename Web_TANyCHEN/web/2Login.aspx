<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="2Login.aspx.cs" Inherits="Web_TANyCHEN.Login" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
     <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="inicio.css">
    <script src="inicio.js" defer></script>
</head>
<body>
   <header>
        <div class="logo">Medical Center</div>
        <button class="menu-toggle" aria-label="Toggle navigation">☰</button>
        <nav>
            <ul class="nav-links">
                <li><a href="1Index.aspx">Home</a></li>
                <li><a href="#about">About Us</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
                <li><a href="2Login.aspx" class="login-btn">Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
    <form id="form1" runat="server">
        <h2>Login</h2>
        <div class="login-div">
            <label for="txtUsername">Username:</label>
            <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
        </div>

        <div class="login-div">
            <label for="txtPassword">Password:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="asp-button" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </form>

    </main>

    <footer>
        <p>© 2024 Medical Center - All Rights Reserved</p>
    </footer>
</body>
</html>
