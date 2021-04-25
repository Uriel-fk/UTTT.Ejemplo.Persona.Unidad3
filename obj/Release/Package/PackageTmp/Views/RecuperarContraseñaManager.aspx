<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarContraseñaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Views.RecuperarContraseñaManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../css/LoginStile.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous"> 
     <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
</head>
<body style="background-color:#EAFCF7; top: -4px; left: 12px;" >
  <div class="login">
     <div class="wrap">
         <div class="user">
            <div class="form-wrap">
             <div class="justify-content-md-center">
                            <h3 class="login-tab "><a class="log-in active" href="#login-tab-content"></a></h3>
                            <h2>Recuperacion de contraseña</h2>
                            <br />
                            <hr />
                    	</div>
                   <div class="tabs-content"> 
                     <div id="login-tab-content" class="active">
                       <form class="login-form" id="form1" runat="server">            
                            <asp:TextBox ID="txtUsuario" runat="server" class="input" placeholder="Nombre de Usuario o email"> </asp:TextBox> <br />
                            <asp:TextBox ID="txtContraseña" runat="server" class="input" placeholder="Contraseña"> </asp:TextBox> <br />
                            <asp:TextBox ID="txtRContraseña" runat="server" class="input" placeholder="Repetir Contraseña"> </asp:TextBox>
                        <asp:Button class="button" ID="btnAceptar" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" OnClientClick="return validaciones();" CssClass="btn btn-outline-success" Width="91px"/> <br />
                           <br />
                     <asp:Button class="button" ID="btnCancelar" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" CssClass="btn btn-outline-danger" Width="91px" />
                                    <br />
                            <br />
                       <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                                    </form>
                                </div>
                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
</body>
</html>
