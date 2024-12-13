<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="4Patients.aspx.cs" Inherits="Web_TANyCHEN._4Patients" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Page</title>
    
    <link rel="stylesheet" href="inicio.css">
    <link rel="stylesheet" href="patient.css">
</head>
<body>
        <header>
        <div class="logo">Medical Center - Patient Details</div>
        <nav>
            <ul>
                <li><a href="2Login.aspx">Logout</a></li>
            </ul>
        </nav>
    </header>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">Patient Information</div>

            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

            
            <div class="section">
                <h3>Basic Information</h3>
                <table>
                    <tr>
                        <th>Field</th>
                        <th>Data</th>
                    </tr>
                    <tr>
                        <td>Name</td>
                        <td><asp:Label ID="lblName" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Date of Birth</td>
                        <td><asp:Label ID="lblDOB" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Address</td>
                        <td><asp:Label ID="lblAddress" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Mobile Phone Number</td>
                        <td><asp:Label ID="lblMobile" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
            </div>

            
            <div class="section">
                <h3>Medical History</h3>
                <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="AppointmentDate" HeaderText="Appointment Date  " />
                        <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" />
                        <asp:BoundField DataField="Treatment" HeaderText=" Treatment" />
                    </Columns>
                </asp:GridView>
            </div>

            
            <div class="actions">
                <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="BtnLogout_Click" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
