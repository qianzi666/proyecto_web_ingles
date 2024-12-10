<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="2Login.aspx.cs" Inherits="Web_TANyCHEN.Login" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
     <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="inicio.css">
</head>
<body>
    <header>
        <div class="logo">Centro medico</div>
        <nav>
            <ul>
                <li><a href="1Index.aspx">Inicio</a></li>
                <li><a href="#about">Sobre Nosotros</a></li>
                <li><a href="#services">Servicio</a></li>
                <li><a href="#contact">Contacto</a></li>
                <li><a href="2Login.aspx" class="login-btn">Login</a></li> 
            </ul>
        </nav>
    </header>

    <main>
    <form id="form1" runat="server">
        <h2>Login</h2>
        <div class="login-div">
            <label for="txtUsername">Nombre de usuario:</label>
            <asp:TextBox ID="txtUsername" runat="server" Placeholder="Nombre de usuario"></asp:TextBox>
        </div>

        <div class="login-div">
            <label for="txtPassword">Contraseña:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Contraseña"></asp:TextBox>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="asp-button" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </form>

    </main>

    <footer>
       <p>© 2024 Centro Médico - Todos los derechos reservados</p>
    </footer>
</body>
</html>
