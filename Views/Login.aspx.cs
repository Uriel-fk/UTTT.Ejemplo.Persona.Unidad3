using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using UTTT.Ejemplo.Persona.Control.Ctrl;

namespace UTTT.Ejemplo.Persona.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            try
            {
                DataContext db = new DcGeneralDataContext();
                String mensaje = String.Empty;
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
                var dbUser = db.GetTable<Usuario>().FirstOrDefault(u => u.strUsuario == this.txtUsername.Text.Trim());
                if (dbUser == null)
                {
                    this.lblMensaje.Text = "Verifique los datos";
                    this.lblMensaje.Visible = true;
                    return;
                }
                if (dbUser.CatValorUsuario != 1)
                {
                    this.lblMensaje.Text = "Usuario no está activo";
                    this.lblMensaje.Visible = true;
                    return;
                }
                var passDec = this.DesEncriptar(dbUser.strPassword);
                if (!passDec.Equals(this.txtPassword.Text.Trim()))
                {
                    this.lblMensaje.Text = "El usuario o la contraseña no son correctos";
                    this.lblMensaje.Visible = true;
                    return;
                }
                Session["UsernameSession"] = dbUser.strUsuario;
                this.Response.Redirect("~/Views/PaginaInicio.aspx", false);

            }
            catch (Exception ex)
            {

                var smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                string strHost = smtpSection.Network.Host;
                int port = smtpSection.Network.Port;
                string strUserName = smtpSection.Network.UserName;
                string strFromPass = smtpSection.Network.Password;
                SmtpClient smtp = new SmtpClient(strHost, port);
                MailMessage msg = new MailMessage();
                string body = "<h1>Error" + ex.Message + "</h1>";
                msg.From = new MailAddress(smtpSection.From, "Prueba");
                msg.To.Add(new MailAddress("1300156@uttt.edu.mx"));
                msg.Subject = "Correo";
                msg.IsBodyHtml = true;
                msg.Body = body;
                smtp.Credentials = new NetworkCredential(strUserName, strFromPass);
                smtp.EnableSsl = true;
                smtp.Send(msg);

                Response.Redirect("~/MensajeError.aspx", false);
            }
        }

        private bool validacion(ref String mensaje)
        {
            if (txtUsername.Text.Trim().Length == 0)
            {
                mensaje = "Nombre de usuario no puede estar vacio";
                return false;
            }
            if (txtUsername.Text.Trim().Length > 15)
            {
                mensaje = "Nombre de usuario solo puede tener 15 caracteres como máximo.";
                return false;
            }
            if (txtPassword.Text.Trim().Length == 0)
            {
                mensaje = "La contraseña es necesaria";
                return false;
            }
            if (this.txtPassword.Text.Trim().Length > 15)
            {
                mensaje = "La contraseña solo puede 15 caracteres como máximo.";
                return false;
            }
            return true;
        }
        public bool sqlInjectionValida(ref String _mensaje)
        {
            CtrlValidaInjection valida = new CtrlValidaInjection();
            String _mensajeFuncion = String.Empty;
            if (valida.sqlInjectionValida(this.txtUsername.Text.Trim(), ref _mensajeFuncion, "Nombre de usuario", ref this.txtUsername))
            {
                _mensaje = _mensajeFuncion;
                return false;
            }
            if (valida.sqlInjectionValida(this.txtPassword.Text.Trim(), ref _mensajeFuncion, "Contraseña", ref this.txtPassword))
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
            if (valida.htmlInjectionValida(this.txtUsername.Text.Trim(), ref mensajeFuncion, "Nombre de usuario", ref this.txtUsername))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInjectionValida(this.txtPassword.Text.Trim(), ref mensajeFuncion, "Contraseña", ref this.txtPassword))
            {
                _mensaje = mensajeFuncion;
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
            //result = System.Text.Encoding.Unicode.GetString(decryted, 0, decryted.ToArray().Length);
            result = System.Text.Encoding.Unicode.GetString(decryted);
            return result;
        }
    }
}