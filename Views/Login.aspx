<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Views.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <title>Inicio de Sesion</title>
</head>
<body style="background-color:#EAFCF7">
    <form id="form1" runat="server">
        <br />
        <div class="mb-3">
            <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Login</h2>
        </div>
        <br />
        
        <div class="row d-flex justify-content-center mt-3">
            <div class="col-md-4" style="width:400px;""text-white text-center">
        <div class="md-2">
            <asp:Label Text="Email" runat="server" />
                <div class="padre">
                    <asp:TextBox ID="txtUsername" runat="server" class="input" placeholder="Email" ViewStateMode="Disabled"></asp:TextBox> <br />
                </div>
                <br />
             <asp:Label Text="Password" runat="server" />
                <div class="mb-3">
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" class="input" placeholder="Contraseña" ViewStateMode="Disabled"></asp:TextBox> <br />
                </div>
            <br />
                <div class="mb-3">
                 <asp:Button ID="Button1" runat="server" class="button" Text="Entrar" OnClick="Button1_Click" CssClass="btn btn-outline-success" Width="119px" />	 
                </div>
            <br />
      <div class="help-action">
         <a class="forgot" href="RecuperarContraseñaPrincipal.aspx">Olvidaste tu contaseña</a>
      </div>
         <div class="mb-2">
            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
          </div>

             </div>
        </div>
    </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
