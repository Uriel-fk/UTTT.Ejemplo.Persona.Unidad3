using System;
using System.Configuration;
using System.Data.Linq;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;
using UTTT.Ejemplo.Linq.Data.Entity;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;

namespace UTTT.Ejemplo.Persona.Views
{
    public partial class RecuperarContraseñaManager : System.Web.UI.Page
    {
        private String recoveryToken;
        protected void Page_Load(object sender, EventArgs e)
        {
            DataContext db = new DcGeneralDataContext();
            var token = Request.QueryString["token"] as String;
            if (token == null)
            {
                Response.Redirect("~/Views/Login.aspx", false);
                return;
            }
            this.recoveryToken = token;
            var user = db.GetTable<Usuario>().FirstOrDefault(u => u.strTokenRecorver == token);
            if (user == null)
            {
                Response.Redirect("~/Views/RecuperarContraseñaPrincipal.aspx", false);
                return;
            }
            else
            {
                var _persona = db.GetTable<Linq.Data.Entity.Persona>().FirstOrDefault(p => p.id == user.strNombrePersona);
                this.txtUsuario.Text = user.strUsuario;
                this.txtUsuario.Enabled = false;
                this.txtUsuario.Text = _persona.strCorreo;
                this.txtUsuario.Enabled = false;

            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Login.aspx", false);
        }


        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
                return;
            }
            try
            {
                DataContext db = new DcGeneralDataContext();
                String mensaje = String.Empty;
                var usuario = db.GetTable<Usuario>().FirstOrDefault(u => u.strTokenRecorver == this.recoveryToken);
                if (!this.validacion(ref mensaje))
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
                usuario.strPassword = this.Encriptar(this.txtContraseña.Text.Trim());
                usuario.strTokenRecorver = null;
                db.SubmitChanges();
                Session["UsernameSession"] = usuario.strUsuario;
                Response.Redirect("~/Views/Login.aspx", false);
            }
            catch (Exception ex)
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
                string body = "<h1>Error" + ex.Message + "</h1>";
                msg.From = new MailAddress(smtpSection.From, "Prueba");
                msg.To.Add(new MailAddress("17300174@uttt.edu.mx"));
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


        private bool validacion(ref String mensaje)
        {

            // Validacion de contraseña

            if (txtContraseña.Text.Trim().Length == 0)
            {
                mensaje = "La contraseña es necesaria";
                return false;
            }
            if (this.txtContraseña.Text.Trim().Length > 15)
            {
                mensaje = "La contraseña solo puede tener 15 caracteres como máximo.";
                return false;
            }
            if (this.txtContraseña.Text.Trim().Length < 5)
            {
                mensaje = "La contraseña es muy corta.";
                return false;
            }
            if (txtRContraseña.Text.Trim().Length == 0)
            {
                mensaje = "La contraseña es necesaria que se ingrese";
                return false;
            }
            if (!txtRContraseña.Text.Trim().Equals(txtContraseña.Text.Trim()))
            {
                mensaje = "Las contraseñas no coinciden.";
                return false;
            }
            return true;
        }
        public bool sqlInjectionValida(ref String _mensaje)
        {
            CtrlValidaInjection valida = new CtrlValidaInjection();
            String _mensajeFuncion = String.Empty;
            if (valida.sqlInjectionValida(this.txtContraseña.Text.Trim(), ref _mensajeFuncion, "Contraseña", ref this.txtContraseña))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (valida.sqlInjectionValida(this.txtRContraseña.Text.Trim(), ref _mensajeFuncion, "Repetir contraseña", ref this.txtRContraseña))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            return true;
        }

        public bool htmlInjectionValida(ref String _mensaje)
        {
            CtrlValidaInjection valida = new CtrlValidaInjection();
            String mensajeFuncion = String.Empty;
            if (valida.htmlInjectionValida(this.txtContraseña.Text.Trim(), ref mensajeFuncion, "Contraseña", ref this.txtContraseña))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtRContraseña.Text.Trim(), ref mensajeFuncion, "Repetir contraseña", ref this.txtRContraseña))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            return true;
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
    }
}