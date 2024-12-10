<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="4Patients.aspx.cs" Inherits="Web_TANyCHEN._4Patients" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Página del paciente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        header {
            background-color: #004d99;
            color: white;
            padding: 15px;
            text-align: center;
        }

        header .logo {
            font-size: 24px;
            font-weight: bold;
        }

        header nav ul {
            list-style: none;
            padding: 0;
            margin: 10px 0 0;
            text-align: center;
        }

        header nav ul li {
            display: inline;
            margin: 0 15px;
        }

        header nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        header nav ul li a:hover {
            text-decoration: underline;
        }

        .container {
            width: 80%;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .header {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .section {
                max-width: 800px;
            margin-bottom: 20px;
        }

        .section h3 {
            margin-bottom: 15px;
            color: #004d99;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        td {
            background-color: #fff;
        }

        .actions {
            text-align: right;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #004d99;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #003366;
        }

        .error {
            color: red;
            font-weight: bold;
        }

        footer {
            text-align: center;
            padding: 15px;
            background-color: #004d99;
            color: white;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
    <link rel="stylesheet" href="inicio.css">
</head>
<body>
        <header>
        <div class="logo">Centro Médico - Detalles del paciente<</div>
        <nav>
            <ul>
                <li><a href="2Login.aspx">Logout</a></li>
            </ul>
        </nav>
    </header>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">Información del paciente</div>

            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

            <!-- 患者基本信息部分 -->
            <div class="section">
                <h3>Información básica</h3>
                <table>
                    <tr>
                        <th>Campo</th>
                        <th>Dato</th>
                    </tr>
                    <tr>
                        <td>Nombre</td>
                        <td><asp:Label ID="lblName" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Fecha de nacimiento</td>
                        <td><asp:Label ID="lblDOB" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Dirección</td>
                        <td><asp:Label ID="lblAddress" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Número de teléfono móvil</td>
                        <td><asp:Label ID="lblMobile" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
            </div>

            <!-- 医疗记录部分 -->
            <div class="section">
                <h3>Historial médico</h3>
                <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="AppointmentDate" HeaderText="Fecha de la cita" />
                        <asp:BoundField DataField="Diagnosis" HeaderText="Diagnóstico" />
                        <asp:BoundField DataField="Treatment" HeaderText=" Tratamiento" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- 返回按钮 -->
            <div class="actions">
                <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="BtnLogout_Click" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
