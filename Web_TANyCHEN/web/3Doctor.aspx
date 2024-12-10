<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="3Doctor.aspx.cs" Inherits="Web_TANyCHEN.Doctor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Interfaz de gestión para médicos</title>
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



        .btn {
            padding: 5px 10px;
            text-align: center;
            border-radius: 4px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            cursor: pointer;
            border: none;
            display: inline-block;
        }

        .btn-view {
            background-color: #4CAF50; /* Green */
        }

        .btn-update {
            background-color: #2196F3; /* Blue */
        }

        .btn-delete {
            background-color: #f44336; /* Red */
        }

        .btn:hover {
            opacity: 0.9;
        }





        .btn-add-patient {
            padding: 10px 12px;
            background-color: #004d99;
            color: white;
            /* font-size: 16px; */
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            display: inline-block;
            text-align: center;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-add-patient:hover {
            background-color: #45a049; /* Slightly darker green */
            transform: scale(1.05); /* Add a hover effect */
        }

        .btn-add-patient:active {
            background-color: #3e8e41; /* Even darker green when clicked */
            transform: scale(0.95); /* Add a pressed effect */
        }






        /* 通用按钮样式 */
        .link-button {
           display: inline-block;
            /* padding: 8px 12px; */
            /* margin: 2px; */
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            text-align: center;
            cursor: pointer;
            color: white;
            transition: background-color 0.3s, transform 0.2s ease;
            border: none;
        }

        /* 各种按钮的颜色 */
        .link-button.view {
            background-color: #4CAF50; /* 绿色 - 查看 */
        }

        .link-button.update {
            background-color: #004d99; /* 蓝色 - 更新 */
        }

        .link-button.delete {
            background-color: #f44336; /* 红色 - 删除 */
        }

        /* 鼠标悬停和点击效果 */
        .link-button:hover {
            opacity: 0.9;
            transform: scale(1.05);
        }

        .link-button:active {
            transform: scale(0.95);
        }
        /* 调整按钮容器样式 */
        .button-container {
            display: flex;
            flex-wrap: wrap; /* 允许换行 */
            gap: 10px; /* 按钮之间的间距 */
        }

        /* 调整每个按钮的宽度和布局 */
        .button-container .link-button {
            flex: 1 1 calc(50% - 10px); /* 每个按钮占据 50% 宽度，减去间距 */
            box-sizing: border-box; /* 包含内边距和边框 */
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
        <div class="logo">Centro Médico - Gestión de médicos</div>
        <nav>
            <ul>
                <li><a href="2Login.aspx">Logout</a></li>
            </ul>
        </nav>
    </header>
    <form id="form1" runat="server">
        <h2>Interfaz de gestión para médicos</h2>

        <!-- 搜索患者部分 -->
        <div class="form-group">
            <label for="txtSearchKeyword">Buscar pacientes：</label>
            <asp:TextBox ID="txtSearchKeyword" runat="server" Placeholder="Ingrese el nombre"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Buscar" OnClick="BtnSearch_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        </div>

        <hr />

        <div class="container">
            <!-- 左侧患者列表 -->
            <div class="left-panel">
                <h3>Lista de pacientes</h3>
                <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False"
                    AllowPaging="True" PageSize="10" DataKeyNames="Id" OnRowCommand="GvPatients_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Name" HeaderText="Nombre" />
                        <asp:BoundField DataField="DOB" HeaderText="Fecha de nacimiento" />
                        <asp:BoundField DataField="Address" HeaderText="Dirección" />
                        <asp:BoundField DataField="Mobile" HeaderText="Número de teléfono " />
                        <asp:BoundField DataField="PIN" HeaderText="Código PIN" />
                        <asp:TemplateField>
                            <ItemTemplate>
                               <div class="button-container">
                                <asp:LinkButton ID="btnViewRecords" runat="server" CommandName="ViewRecords"
                                    CommandArgument='<%# Eval("Id") %>' Text="Ver registros" CssClass="link-button view" />
                                <asp:LinkButton ID="btnUpdatePatient" runat="server" CommandName="UpdatePatient"
                                    CommandArgument='<%# Eval("Id") %>' Text="Actualizar paciente" CssClass="link-button update" />
                                <asp:LinkButton ID="btnDeletePatient" runat="server" CommandName="DeletePatient"
                                    CommandArgument='<%# Eval("Id") %>' Text="Eliminar paciente" CssClass="link-button delete" />
                            </div>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

              <asp:Button ID="btnAddPatient" runat="server" Text="Añadir paciente" CssClass="btn btn-add-patient" OnClientClick="openModal('addPatientModal'); return false;" />

            </div>

            <!-- 右侧医疗记录 -->
            <div class="right-panel">
                <h3>Historial médico</h3>
               <asp:GridView ID="gvMedicalRecords" runat="server" AutoGenerateColumns="False" OnRowCommand="GvMedicalRecords_RowCommand">
    <Columns>
        <asp:BoundField DataField="Id" HeaderText="ID de registro" />
        <asp:BoundField DataField="AppointmentDate" HeaderText="Fecha de la cita" />
        <asp:BoundField DataField="Diagnosis" HeaderText="Diagnóstico" />
        <asp:BoundField DataField="Treatment" HeaderText="Tratamiento" />
        <asp:TemplateField>
            <ItemTemplate>
        <div style="display: flex; gap: 10px;">
        <asp:LinkButton ID="btnViewRecords" runat="server" CommandName="ViewRecords"
            CommandArgument='<%# Eval("Id") %>' Text="Ver registros" CssClass="btn btn-view" />
        <asp:LinkButton ID="btnUpdatePatient" runat="server" CommandName="UpdatePatient"
            CommandArgument='<%# Eval("Id") %>' Text="Actualizar paciente" CssClass="btn btn-update" />
        <asp:LinkButton ID="btnDeletePatient" runat="server" CommandName="DeletePatient"
            CommandArgument='<%# Eval("Id") %>' Text="Eliminar paciente" CssClass="btn btn-delete" />
    </div>
</ItemTemplate>

        </asp:TemplateField>
    </Columns>
</asp:GridView>

<!-- 添加医疗记录按钮 -->
<asp:Button ID="btnAddMedicalRecord" runat="server" Text="Agregar registro" CssClass="btn btn-add-patient" OnClientClick="openModal('addRecordModal'); return false;" />

            </div>
        </div>
        <asp:HiddenField ID="hfSelectedPatientId" runat="server" />
<asp:HiddenField ID="hfSelectedRecordId" runat="server" />

        <!-- 添加患者弹窗 -->
        <div id="addPatientModal" class="modal">
            <div class="modal-header">Añadir paciente</div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientName" runat="server" Placeholder="Nombre"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientDOB" runat="server" Placeholder="Fecha de nacimiento"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientAddress" runat="server" Placeholder="Dirección"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientMobile" runat="server" Placeholder="Número de teléfono móvil"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalPatientPIN" runat="server" Placeholder="Código PIN"></asp:TextBox>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnModalAddPatient" runat="server" Text="Enviar" OnClick="BtnAddPatient_Click" />
                <button type="button" onclick="closeModal('addPatientModal')">Cancelar</button>
            </div>
        </div>

        <!-- 添加医疗记录弹窗 -->
        <div id="addRecordModal" class="modal">
            <div class="modal-header">Añadir historial médico</div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordDate" runat="server" Placeholder="Fecha de la cita"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordDiagnosis" runat="server" Placeholder="Diagnóstico"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtModalRecordTreatment" runat="server" Placeholder="Tratamiento"></asp:TextBox>
            </div>
            <div class="modal-actions">
                <asp:Button ID="btnModalAddRecord" runat="server" Text="Enviar" OnClick="BtnAddMedicalRecord_Click" />
                <button type="button" onclick="closeModal('addRecordModal')">Cancelar</button>
            </div>
        </div>
    </form>
</body>
</html>

