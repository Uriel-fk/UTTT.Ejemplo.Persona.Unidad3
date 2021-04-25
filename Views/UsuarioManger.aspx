<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioManger.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Views.UsuarioManger" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

</head>
<body class="bg-light">
    
   <form id="formulario" runat="server"> 
           <asp:ScriptManager ID="ScriptManager1" 
                               runat="server" />

            <input id="txtFecha" runat="server" type="hidden" />
        <br />
    <div style="font-family: Arial; font-size: medium; font-weight: bold">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <asp:Label ID="lblPersona" runat="server" Text="Usuario" Font-Bold="True"></asp:Label>
    </div>
      
          <div class="row justify-content-md-center">
             <div>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True"></asp:Label>
        </div>
              </div>   
 <br />
         <div class="container well">
                 
                 <div class="row form-group">
                     
                       <asp:Label ID="Label3" runat="server" Text="Persona:"  class="col-sm-2 col-form-label"></asp:Label>
                    
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>
                             <asp:DropDownList ID="ddlPersona" runat="server"
                                 Height="40px" Width="253px"
                                 CssClass="form-control col-auto">
                             </asp:DropDownList>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPersona" EnableClientScript="False" ErrorMessage="Elija una persona" InitialValue="-1"></asp:RequiredFieldValidator>
                 </div>
             <div class="row form-group">
                         <asp:Label ID="Label5" runat="server" Text="Nombre Usuario:"  class="col-sm-2 col-form-label"></asp:Label>
                     <asp:TextBox runat="server" ID="txtPersonaEditar"  Width="249px" ViewStateMode="Disabled" Class="form-control col-auto" />
                       
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ErrorMessage="Escribe El Nombre De Tu Usuario  " ControlToValidate="txtPersonaEditar"></asp:RegularExpressionValidator>
             </div>
                 <div class="row form-group">
                     
                         <asp:Label ID="Label6" runat="server" Text=" Contraseña:"  class="col-sm-2 col-form-label"></asp:Label>
                    
                      <asp:TextBox runat="server" ID="txtPassword" Width="249px" ViewStateMode="Disabled"  Class="form-control col-auto" MaxLength="20" placeholder="Ingresa Tu Contraseña"></asp:TextBox>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ErrorMessage="Escribe Tu Contraseña. No La Vallas A Olvidar  " ControlToValidate="txtPassword"></asp:RegularExpressionValidator>
                         <br />
                     </div>

                 <div class="row form-group">
                     
                         <asp:Label ID="Label7" runat="server" Text="Repetir Contraseña:"  class="col-sm-2 col-form-label"></asp:Label>
                    
                     <asp:TextBox runat="server" ID="txtPassword2" Width="249px" ViewStateMode="Disabled" Class="form-control col-auto" MaxLength="20" placeholder="Ingresa Una Vez Mas Tu Contraseña"></asp:TextBox>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ErrorMessage="Ya Se Que Es Algo Tedioso Pero Escribe de Nuevo Tu Contraseña " ControlToValidate="txtPassword2"></asp:RegularExpressionValidator>
                 </div>
               
                 <div class="row form-group">
                     <asp:Label ID="lblEstadoEditar" runat="server" Visible="false"  class="col-sm-2 col-form-label">Estado Usuario</asp:Label>
                     <asp:DropDownList ID="ddlEstadoUsuario" runat="server"  Height="40px" Width="253px" CssClass="form-control col-auto">
                     </asp:DropDownList>

                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlEstadoUsuario" EnableClientScript="False" ErrorMessage="¿A donde? primero sea tan amable y elija un Estado De Usuario" InitialValue="-1"></asp:RequiredFieldValidator>
                    </div>

                 <div class="row form-group">
                 <asp:Label ID="lblCalendar2" runat="server" Text="Fecha de Registro:" class="col-sm-2 col-form-label" ></asp:Label>
                 &nbsp;
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                         <ContentTemplate> 
                             
                            <asp:TextBox ID="txtFechaNac2" placeholder="15/04/2021" runat="server"  MaxLength="10" class="form-control" Height="35px" Width="248px" pattern="(((19|20)([2468][048]|[13579][26]|0[48])|2000)[/-]02[/-]29|((19|20)[0-9]{2}[/-](0[4678]|1[02])[/-](0[1-9]|[12][0-9]|30)|(19|20)[0-9]{2}[/-](0[1359]|11)[/-](0[1-9]|[12][0-9]|3[01])|(19|20)[0-9]{2}[/-]02[/-](0[1-9]|1[0-9]|2[0-8])))"></asp:TextBox>
                             <asp:ImageButton ID="imbtnCalendar" runat="server" Height="25px" ImageUrl="~/Images/Calendario.jpg" Width="25px" />
                             <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy/MM/dd" PopupButtonID="imbtnCalendar" PopupPosition="BottomRight" TargetControlID="txtFechaNac2"></ajaxToolkit:CalendarExtender>
                             <asp:Label ID="lblCalendario" runat="server" ForeColor="Red" Text="." Visible="False"></asp:Label>
                             <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNac2" ErrorMessage="Selecciona la fecha"></asp:RequiredFieldValidator>
                             &nbsp;&nbsp;&nbsp;
                             <br />
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtFechaNac2" ErrorMessage="Fecha Erronea.. Algo anda mal " ValidationExpression="(((19|20)([2468][048]|[13579][26]|0[48])|2000)[/-]02[/-]29|((19|20)[0-9]{2}[/-](0[4678]|1[02])[/-](0[1-9]|[12][0-9]|30)|(19|20)[0-9]{2}[/-](0[1359]|11)[/-](0[1-9]|[12][0-9]|3[01])|(19|20)[0-9]{2}[/-]02[/-](0[1-9]|1[0-9]|2[0-8])))" ForeColor="#000099"></asp:RegularExpressionValidator>

                         </ContentTemplate>
                     </asp:UpdatePanel>

             </div>    
                 <div class="form-group">
                     <br />
                     &nbsp;<asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
            onclick="btnCancelar_Click" ViewStateMode="Disabled" class="btn btn-outline-danger" Height="31px" Width="116px"/>
                     &nbsp;
                     <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" 
            onclick="btnAceptar_Click" ViewStateMode="Disabled" OnClientClick="return valid();" class="btn btn-outline-success" Width="108px" Height="32px"/>
                     <br />
                     <br />
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:Label ID="lblUser" runat="server"></asp:Label>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 <asp:Label ID="lblMensaje" runat="server" class="col-sm-2 col-form-label"></asp:Label>

                 </div>

    </div>
  </div>           
    </form>
</body>
</html>
