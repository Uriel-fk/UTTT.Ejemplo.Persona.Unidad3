...<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" debug=false%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head runat="server"><title></title><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script><script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script><link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"></head><body class="bg-light"><form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" 
                               runat="server" />
        <input id="txtFecha" runat="server" type="hidden" />
        <br />
    <div style="font-family: Arial; font-size: medium; font-weight: bold">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <asp:Label ID="lblPersona" runat="server" Text="Persona" Font-Bold="True"></asp:Label>
    </div>
      
          <div class="container well">
             <div>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True"></asp:Label>
        </div>
 <br />
        

        <div class="row form-group"> 
            <asp:Label ID="lblSexo" runat="server" Text="Sexo:"  class="col-sm-2 col-form-label"></asp:Label>
            &nbsp;
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>
            <asp:DropDownList ID="ddlSexo" runat="server" Height="40px" Width="253px" onselectedindexchanged="ddlSexo_SelectedIndexChanged" CssClass="form-control col-auto">
            </asp:DropDownList>
                </ContentTemplate>
                     </asp:UpdatePanel>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlSexo" EnableClientScript="False" ErrorMessage="¿Eres Hombre o Mujer?" InitialValue="-1"></asp:RequiredFieldValidator>

            </div>

              <%--Estado civil--%>
              <div class="row form-group"> 
            <asp:Label ID="lblEstado" runat="server" Text="Estado civil:" class="col-sm-2 col-form-label"></asp:Label>
            <asp:DropDownList ID="ddlEstadoCivil" runat="server" Height="40px" Width="253px" CssClass="form-control col-auto"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvEstadoC" runat="server" ControlToValidate="ddlEstadoCivil" EnableClientScript="False" ErrorMessage="Eres Casado, Soltero, Viudo, Divorciado etc..." InitialValue="-1"></asp:RequiredFieldValidator>
                  </div>
               

        <div class="row form-group"> 
            <asp:Label ID="lblClave" runat="server" Text="Clave Unica:"  class="col-sm-2 col-form-label"></asp:Label>
            <asp:TextBox ID="txtClaveUnica" runat="server" Width="249px" ViewStateMode="Disabled" MaxLength="3" Class="form-control col-auto" placeholder="Clave" required='required'></asp:TextBox>
        
            <asp:RegularExpressionValidator ID="RevClave" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="La clave debe contener 3 digitos" ValidationExpression="\d{3}"></asp:RegularExpressionValidator>
        
        </div>

        

        <div class="row form-group">
        
            <asp:Label ID="Label1" runat="server" Text="Nombre:"  class="col-sm-2 col-form-label"></asp:Label>
            <asp:TextBox ID="txtNombre" runat="server" Width="249px" ViewStateMode="Disabled" MaxLength="15" Class="form-control col-auto" placeholder="Ingrese Nombre" required='required'></asp:TextBox>
        
            <asp:RegularExpressionValidator ID="RevNom" runat="server" ControlToValidate="txtNombre" ErrorMessage="Epale aqui todo el mundo tiene un nombre asi que escribe tu nombre en este recuadro" ValidationExpression="[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]{3,15}"></asp:RegularExpressionValidator>
        </div>

        <div class="row form-group"> 
            
            <asp:Label ID="Label2" runat="server" Text="A Paterno:" class="col-sm-2 col-form-label"></asp:Label>
            <asp:TextBox ID="txtAPaterno" runat="server" Width="249px" ViewStateMode="Disabled" MaxLength="15" Class="form-control col-auto" placeholder="Apellido Paterno" required='required'></asp:TextBox>
            <asp:RegularExpressionValidator ID="RevAP" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="Caracteres minimos 3 letras, maximo 15" ValidationExpression="[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]{3,15}"></asp:RegularExpressionValidator>
        </div>


        <div class="row form-group">
            <asp:Label ID="Label3" runat="server" Text="A Materno:"  class="col-sm-2 col-form-label"></asp:Label>
            <asp:TextBox ID="txtAMaterno" runat="server" Width="248px" 
                ViewStateMode="Disabled" MaxLength="15" Class="form-control col-auto" placeholder="Apellido Materno"></asp:TextBox>
        </div>

      

        <input id="val" type="hidden" runat="server"/>

    <div class="row form-group">   
       <asp:Label ID="Label4" runat="server" Text="Num. Hermanos:"  class="col-sm-2 col-form-label"></asp:Label>
        <asp:TextBox ID="txtHermanos" runat="server" Width="246px" Class="form-control col-auto" placeholder="Numero de hermanos" MaxLength="1" required='required'></asp:TextBox>
    
        <asp:RegularExpressionValidator ID="RevNHermanos" runat="server" ControlToValidate="txtHermanos" ErrorMessage="Solo se aceptan numeros enteros!!!" ValidationExpression="^\d*$"></asp:RegularExpressionValidator>
    </div>

             <div class="row form-group">
                 <asp:Label ID="lblCalendar2" runat="server" Text="Fecha de nacimiento:" class="col-sm-2 col-form-label" ></asp:Label>
                 &nbsp;
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                         <ContentTemplate> 
                             <br />
                             <asp:TextBox ID="txtFechaNac2" placeholder="00/00/0000" runat="server" OnTextChanged="txtFechaNac2_TextChanged" MaxLength="10" class="form-control" Height="35px" Width="248px" required="Fecha de nacimiento requerido" pattern="(((19|20)([2468][048]|[13579][26]|0[48])|2000)[/-]02[/-]29|((19|20)[0-9]{2}[/-](0[4678]|1[02])[/-](0[1-9]|[12][0-9]|30)|(19|20)[0-9]{2}[/-](0[1359]|11)[/-](0[1-9]|[12][0-9]|3[01])|(19|20)[0-9]{2}[/-]02[/-](0[1-9]|1[0-9]|2[0-8])))"></asp:TextBox>
                             <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy/MM/dd" PopupButtonID="imbtnCalendar" PopupPosition="BottomRight" TargetControlID="txtFechaNac2"></ajaxToolkit:CalendarExtender>
                             <asp:Label ID="lblCalendario" runat="server" ForeColor="Red" Text="." Visible="False"></asp:Label>
                             <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNac2" ErrorMessage="Seleccione la fecha"></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="txtFechaNac2" ErrorMessage="Fecha invalida" ValidationExpression="(((19|20)([2468][048]|[13579][26]|0[48])|2000)[/-]02[/-]29|((19|20)[0-9]{2}[/-](0[4678]|1[02])[/-](0[1-9]|[12][0-9]|30)|(19|20)[0-9]{2}[/-](0[1359]|11)[/-](0[1-9]|[12][0-9]|3[01])|(19|20)[0-9]{2}[/-]02[/-](0[1-9]|1[0-9]|2[0-8])))" ForeColor="#000099"></asp:RegularExpressionValidator>

                         </ContentTemplate>
                     </asp:UpdatePanel>

             </div>
   
            

        <div class="row form-group"> 
        <asp:Label ID="Label6" runat="server" Text="Correo Electronico:"  class="col-sm-2 col-form-label" style="top: 0px; left: 0px"></asp:Label>
        <asp:TextBox ID="txtCorreo" runat="server" Width="246px" CssClass="form-control col-auto" placeholder="Correo Electronico" required='required' pattern="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:TextBox>
    
            <asp:RegularExpressionValidator ID="RevCorreo" runat="server" ControlToValidate="txtCorreo" ErrorMessage="Correo no valido" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
    </div>
    

         <div class="row form-group">    
        <asp:Label ID="Label7" runat="server" Text="RFC:"  class="col-sm-2 col-form-label"></asp:Label>
             <asp:TextBox ID="txtRfc" runat="server" Width="246px" CssClass="form-control col-auto" placeholder="RFC" MaxLength="13" required='required'></asp:TextBox>
    
             <asp:RegularExpressionValidator ID="RevRfc" runat="server" ControlToValidate="txtRfc" ErrorMessage="RFC incorrecto" ValidationExpression="^[a-zA-Z]{3,4}(\d{6})((\D|\d){2,3})?$"></asp:RegularExpressionValidator>
    </div>
    

    <div class="row form-group">       
        <asp:Label ID="Label8" runat="server" Text="Codigo Postal:"  class="col-sm-2 col-form-label"></asp:Label>
        <asp:TextBox ID="txtCPostal" runat="server" Width="246px" MaxLength="5" CssClass="form-control col-auto" placeholder="Codigo Postal" required='required'></asp:TextBox>
    
        <asp:RegularExpressionValidator ID="RevCPostal" runat="server" ControlToValidate="txtCPostal" ErrorMessage="Codigo postal debe contener 5 digitos" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
    </div>
              <br />
        <div class="row form-group">
     
        <asp:Label ID="Error" runat="server" class="col-sm-2 col-form-label"></asp:Label> 
            <br /> 
            <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" 
            onclick="btnAceptar_Click" ViewStateMode="Disabled" OnClientClick="return valid();" class="btn btn-outline-success"/>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
            onclick="btnCancelar_Click" ViewStateMode="Disabled" class="btn btn-outline-danger"/>
     <br />
             <br />
             <div class="container body-content">
        
    </div>
    </div>

    </div>
    </form>
    <script src ="Scripts/ValidacionManager.js"></script>
</body>
</html>