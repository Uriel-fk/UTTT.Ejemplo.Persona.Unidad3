<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Views.UsuarioPrincipal" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
</head>
<body class="bg-light">
    <div class="container-fluid">
        <form id="form1" runat="server">
              <asp:ScriptManager ID="ScriptManager1"
                runat="server" />
            <div>
                <div style="font-family: Arial; font-size:smaller; font-weight: bold">
                    <h1 class="text-center">Nombre Del Usuario:
                        </h1>
                </div>
                <br />
                     <asp:UpdatePanel ID="paneltxtName" runat="server">
                             <ContentTemplate>
                                 <asp:Button style="display: none;" ID="btnTrick" runat="server" OnClick="btnTrick_Click"/>
                             </ContentTemplate>
                        </asp:UpdatePanel>
         <div>
    <p>
        &nbsp;&nbsp;&nbsp;Nombre Usuario:&nbsp;&nbsp;&nbsp;

       <div style="margin-left: 80px">
           <asp:TextBox ID="txtNombre" runat="server"
                           Height="40px" Width="240px" ViewStateMode="Disabled" Class="form-control" placeholder="Ingresa El Nombre del Usuario" OnTextChanged="txtNombre_TextChanged" MaxLength="20" ></asp:TextBox>
           <br />
        </div>  
    </div>

                    <div>
        <div>    
        &nbsp;&nbsp;Estado:&nbsp;&nbsp;&nbsp;&nbsp; </div>
       <div style="margin-left: 80px">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlEstado" runat="server" Height="40px" Width="202px" Class="form-control">
                        </asp:DropDownList>
            <br />
    </div>
    </div>
                    <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
         <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
            onclick="btnBuscar_Click" ViewStateMode="Disabled" class="btn btn-outline-info" Width="101px"/>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" 
            onclick="btnAgregar_Click" ViewStateMode="Disabled" class="btn btn-outline-dark"/>
        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="BtnRegresar" runat="server" Text="Inicio" 
                            Class="btn btn-outline-success" OnClick="BtnRegresar_Click" Width="117px"/>
                    
                
                 <div style="font-weight: bold" class="mt-4">
                        <h3 class="text-center">&nbsp;</h3> 
                    </div>
                  <div style="margin-left: 10px" class="table-responsive">
                     
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        &nbsp;<asp:GridView ID="dgvUsuarios" runat="server" AutoGenerateColumns="False" DataSourceID="DataSourceUsuario" 
                                            OnRowCommand="dgvUsuarios_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1069px" 
                                            CellPadding="3" BackColor="White" 
                                             BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                                             ViewStateMode="Disabled" class="table table-striped" Height="224px">
                                            <Columns>
                                                <asp:BoundField DataField="Persona.strNombre" HeaderText="Nombre Persona" ReadOnly="True" SortExpression="Persona.strNombre" />
                                                <asp:BoundField DataField="strUsuario" 
                                                    HeaderText="Nombre Usuario" ReadOnly="True" SortExpression="strUsuario" />
                                                <asp:BoundField DataField="dteFechaRegistro" HeaderText="Fecha Registro" ReadOnly="True" SortExpression="dteFechaRegistro" />
                                                <asp:BoundField DataField="CatStatusUsuario.strValor" HeaderText="Estado" ReadOnly="True" SortExpression="CatStatusUsuario.strValor" />
                                                <asp:TemplateField HeaderText="Editar">
                                                    <ItemTemplate>
                                                        <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />

                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Eliminar">
                                                    <ItemTemplate>
                                                        <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/delrecord_16x16.png" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                </asp:TemplateField>
                                            </Columns>
                                           <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
                                        </asp:GridView>

                                        <asp:LinqDataSource ID="DataSourceUsuario" runat="server" ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" EntityTypeName="" Select="new (strNombrePersona, strUsuario, CatValorUsuario, dteFechaRegistro, CatStatusUsuario, Persona, id)" TableName="Usuario" OnSelecting="DataSourceUsuario_Selecting">
                                        </asp:LinqDataSource>

                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                  
                                </div>
                            
            </div>
        </form>
           <script type="text/javascript">
           
            document.querySelector('#txtNombre').addEventListener('keyup',  () => {
                const btnTrick = document.querySelector('#btnTrick');
                //  console.log(nombre);
                btnTrick.click();
            });
        </script>
    </div>
</body>
</html>
