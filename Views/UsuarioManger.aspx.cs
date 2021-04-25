using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
namespace UTTT.Ejemplo.Persona.Views
{
    public partial class UsuarioManger : System.Web.UI.Page
    {
        private Usuario baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        private SessionManager session = new SessionManager();
        private int idUsuarios = 0;
        private int tipoAccion = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            this.lblUser.Text = Session["UsernameSession"] as string;
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idUsuarios = this.session.Parametros["idUsuario"] != null ?
                    int.Parse(this.session.Parametros["idUsuario"].ToString()) : 0;
                if (this.idUsuarios == 0)
                {
                    this.baseEntity = new Usuario();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Usuario>().First(u => u.id == this.idUsuarios);
                    this.tipoAccion = 2;
                }
                this.txtPassword.Attributes.Add("type", "password");
                this.txtPassword2.Attributes.Add("type", "password");
                if (!IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<Linq.Data.Entity.Persona> personas = this.dcGlobal.GetTable<Linq.Data.Entity.Persona>().ToList();
                    this.ddlPersona.DataTextField = "NombreCompleto";
                    this.ddlPersona.DataValueField = "id";
                    if (this.idUsuarios == 0)
                    {
                        this.lblAccion.Text = "Agregar";
                        this.ddlPersona.DataSource = personas;
                        this.ddlPersona.DataBind();
                        this.ddlEstadoUsuario.Visible = false;
                        this.lblEstadoEditar.Visible = false;
                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        this.lblEstadoEditar.Visible = true;
                        this.txtPersonaEditar.Visible = true;
                        this.ddlEstadoUsuario.Visible = true;
                        this.ddlPersona.Visible = false;
                        this.txtFechaNac2.Visible = false;
                        this.imbtnCalendar.Visible = false;
                        this.lblCalendar2.Visible = false;
                        List<CatStatusUsuario> estadosUsuario = dcGlobal.GetTable<CatStatusUsuario>().ToList();
                        this.ddlEstadoUsuario.DataTextField = "strValor";
                        this.ddlEstadoUsuario.DataValueField = "id";
                        this.ddlEstadoUsuario.DataSource = estadosUsuario;
                        this.ddlEstadoUsuario.DataBind();
                        this.setItem(ref this.ddlEstadoUsuario, baseEntity.CatStatusUsuario.strValor);
                        this.txtPersonaEditar.Text = baseEntity.Persona.NombreCompleto;
                        this.txtPersonaEditar.Text = baseEntity.strUsuario;
                        this.txtFechaNac2.Text = baseEntity.dteFechaRegistro.ToString("yyyy/MM/dd");
                        this.txtPassword.Text = this.DesEncriptar(baseEntity.strPassword);
                        this.txtPassword2.Text = this.DesEncriptar(baseEntity.strPassword);

                    }
                }
                if (this.idUsuarios > 0)
                {
                    this.txtPersonaEditar.Text = baseEntity.Persona.NombreCompleto;
                    this.txtPersonaEditar.Visible = true;
                    this.txtFechaNac2.Visible = false;
                    this.imbtnCalendar.Visible = false;
                    this.lblCalendar2.Visible = false;
                }
            }
            catch (Exception ex)
            {
                this.Response.Redirect("~/Views/UsuarioPrincipal.aspx", false);
            }
        }
        private bool validacion(Usuario _usuario, ref String mensaje)
        {
            DateTime dateValue;
            if (_usuario.strUsuario.Length == 0)
            {
                mensaje = "Nombre de usuario no puede estar vacio";
                return false;
            }
            if (_usuario.strUsuario.Length > 15)
            {
                mensaje = "Nombre de usuario solo acepta 15 caracteres";
                return false;
            }
            if (_usuario.strUsuario.Length < 3)
            {
                mensaje = "Nombre de usuario es muy corto";
                return false;
            }
            if (_usuario.strPassword.Length == 0)
            {
                mensaje = "La contraseña es necesaria";
                return false;
            }
            if (this.txtPassword.Text.Trim().Length > 15)
            {
                mensaje = "La contraseña solo es de 15 caracteres como máximo.";
                return false;
            }
            if (this.txtPassword.Text.Trim().Length < 5)
            {
                mensaje = "La contraseña es de 5 caracteres como mínimo.";
                return false;
            }

            if (!this.txtPassword.Text.Trim().Equals(this.txtPassword2.Text.Trim()))
            {
                mensaje = "Las contraseñas no son iguales";
                return false;
            }

            if (this.txtFechaNac2.Text.Trim().Length == 0 && this.idUsuarios == 0)
            {
                mensaje = "La fecha es requerida";
                return false;
            }


            /* Validacion Calendario

            TimeSpan timeSpan = DateTime.Now - _usuario.dteFechaRegistro.Value.Date;
           
            if (timeSpan.Days >= 737821)
            {
                mensaje = "Ingrese una fecha en el calendario";
                return false;
            }
            */
            /*
          
            */
            return true;
        }

        public bool sqlInjectionValida(ref String _mensaje)
        {
            CtrlValidaInjection valida = new CtrlValidaInjection();
            String _mensajeFuncion = String.Empty;
            if (valida.sqlInjectionValida(this.txtPersonaEditar.Text.Trim(), ref _mensajeFuncion, "Nombre de usuario", ref this.txtPersonaEditar))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (valida.sqlInjectionValida(this.txtPassword.Text.Trim(), ref _mensajeFuncion, "Contraseña", ref this.txtPassword))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (valida.sqlInjectionValida(this.txtPassword2.Text.Trim(), ref _mensajeFuncion, "Repetir Contraseña", ref this.txtPassword2))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (this.idUsuarios == 0)
            {
                return true;
            }
            if (valida.sqlInjectionValida(this.txtFechaNac2.Text.Trim(), ref _mensajeFuncion, "Fecha de ingreso", ref this.txtFechaNac2))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            return true;
        }
        public bool htmlInjectionValida(ref String _mensaje)
        {
            CtrlValidaInyeccion valida = new CtrlValidaInyeccion();
            String mensajeFuncion = String.Empty;
            if (valida.htmlInyectionValida(this.txtPersonaEditar.Text.Trim(), ref mensajeFuncion, "Nombre de usuario", ref this.txtPersonaEditar))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtPassword.Text.Trim(), ref mensajeFuncion, "Contraseña", ref this.txtPassword))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtPassword2.Text.Trim(), ref mensajeFuncion, "Repetir Contraseña", ref this.txtPassword2))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (this.idUsuarios == 0)
            {
                return true;
            }
            if (valida.htmlInyectionValida(this.txtFechaNac2.Text.Trim(), ref mensajeFuncion, "Fecha de ingreso", ref this.txtFechaNac2))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            return true;
        }

        public bool sqlQueryValidation(Usuario usuario, ref String mensaje)
        {
            var user = dcGlobal.GetTable<Usuario>().FirstOrDefault(u => u.strUsuario == usuario.strUsuario);
            if (user != null)
            {
                mensaje = "Ya existe un usuario con ese nombre";
                return false;
            }
            var userInPerson = dcGlobal.GetTable<Usuario>().FirstOrDefault(u => u.strNombrePersona == usuario.strNombrePersona);
            if (userInPerson != null)
            {
                mensaje = "La persona  ya está asociada con un usuario";
                return false;
            }
            return true;
        }
        public bool sqlQueryValidationEditar(Usuario usuario, ref String mensaje)
        {
            var userCount = dcGlobal.GetTable<Usuario>().Where(u => u.strUsuario == usuario.strUsuario && u.id != usuario.id).Count();
            if (userCount > 0)
            {
                mensaje = "Ya existe un usuario con ese nombre";
                return false;
            }

            return true;
        }
        public string Encriptar(string _cadenaAencriptar)
        {
            string result = string.Empty;
            byte[] encryted = System.Text.Encoding.Unicode.GetBytes(_cadenaAencriptar);
            result = Convert.ToBase64String(encryted);
            return result;
        }
        public string DesEncriptar(string _cadenaAdesencriptar)
        {
            string result = string.Empty;
            byte[] decryted = Convert.FromBase64String(_cadenaAdesencriptar);

            result = System.Text.Encoding.Unicode.GetString(decryted);
            return result;
        }

        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                this.Response.Redirect("~/Views/UsuarioPrincipal.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        public static string MD5(string word)
        {
            MD5 md5 = MD5CryptoServiceProvider.Create();
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] stream = null;
            StringBuilder sb = new StringBuilder();
            stream = md5.ComputeHash(encoding.GetBytes(word));
            for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
            return sb.ToString();
        }
        public static string Base64Encode(string word)
        {
            byte[] byt = System.Text.Encoding.UTF8.GetBytes(word);
            return Convert.ToBase64String(byt);
        }
        public static string Base64Decode(string word)
        {
            byte[] b = Convert.FromBase64String(word);
            return System.Text.Encoding.UTF8.GetString(b);
        }
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                DataContext dcGuardar = new DcGeneralDataContext();

                Usuario usuario = new Usuario();
                DateTime dateValue = DateTime.Now;
                if (this.idUsuarios == 0)
                {

                    usuario.strNombrePersona = int.Parse(this.ddlPersona.SelectedValue);
                    usuario.strUsuario = this.txtPersonaEditar.Text.Trim();
                    usuario.strPassword = this.Encriptar(this.txtPassword.Text.Trim());
                    usuario.CatValorUsuario = 1;
                    if (DateTime.TryParseExact(this.txtFechaNac2.Text.Trim(), "yyyy/MM/dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateValue))
                    {
                        usuario.dteFechaRegistro = dateValue;
                    }
                    String mensaje = String.Empty;
                    if (!this.validacion(usuario, ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.sqlInjectionValida(ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.htmlInjectionValida(ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.sqlQueryValidation(usuario, ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    dcGuardar.GetTable<Usuario>().InsertOnSubmit(usuario);
                    dcGuardar.SubmitChanges();
                    this.Response.Redirect("~/Views/UsuarioPrincipal.aspx", false);
                }
                if (this.idUsuarios > 0)
                {
                    usuario = dcGuardar.GetTable<Usuario>().First(u => u.id == this.idUsuarios);
                    usuario.strUsuario = this.txtPersonaEditar.Text.Trim();
                    usuario.strPassword = this.Encriptar(this.txtPassword.Text.Trim());
                    usuario.CatValorUsuario = int.Parse(this.ddlEstadoUsuario.SelectedValue);

                    String mensaje = String.Empty;
                    if (!this.validacion(usuario, ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.sqlInjectionValida(ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.htmlInjectionValida(ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.sqlQueryValidationEditar(usuario, ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    dcGuardar.SubmitChanges();
                    this.Response.Redirect("~/Views/UsuarioPrincipal.aspx", false);
                    // editar
                }
            }
            catch (Exception _e)
            {

                //Obtenemos el servidor smtp del archivo de configuración.
                var smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                string strHost = smtpSection.Network.Host;
                int port = smtpSection.Network.Port;
                string strUserName = smtpSection.Network.UserName;
                string strFromPass = smtpSection.Network.Password;

                //Proporcionamos la información de autenticación al servidor de Gmail
                SmtpClient smtp = new SmtpClient(strHost, port);
                MailMessage msg = new MailMessage();

                //Creamos el contenido del correo. 
                string body = "<h1>Error" + _e.Message + "</h1>";
                msg.From = new MailAddress(smtpSection.From, "Prueba");
                msg.To.Add(new MailAddress("18300156@uttt.edu.mx"));
                msg.Subject = "Correo";
                msg.IsBodyHtml = true;
                msg.Body = body;

                //Enviamos el correo
                smtp.Credentials = new NetworkCredential(strUserName, strFromPass);
                smtp.EnableSsl = true;
                smtp.Send(msg);

                Response.Redirect("~/MensajeError.aspx", false);
            }
        }
    }
}