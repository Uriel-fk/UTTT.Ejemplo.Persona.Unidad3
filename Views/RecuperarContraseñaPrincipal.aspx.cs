using System;
using System.Data.Linq;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using UTTT.Ejemplo.Linq.Data.Entity;
using UTTT.Ejemplo.Persona.Control.Ctrl;

namespace UTTT.Ejemplo.Persona.Views
{
    public partial class RecuperarContraseñaPrincipal : System.Web.UI.Page
    {
        //  PersonaEntities bd = new PersonaEntities();
        DataContext dcGuardar = new DcGeneralDataContext();
        string url;
        private UTTT.Ejemplo.Linq.Data.Entity.Usuario baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("~/Views/Login.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error");
                this.showMessageException(_e.Message);
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            if (!IsValid)
            {
                return;
            }
            try
            {
                CtrlEmail email = new CtrlEmail();
                DataContext db = new DcGeneralDataContext();

                var persona = db.GetTable<Linq.Data.Entity.Persona>().FirstOrDefault(p => p.strCorreo == this.txtCorreoElectronico.Text.Trim());
                if (persona == null)
                {
                    this.lblMensaje.Visible = true;
                    this.lblMensaje.Text = "El correo ingresado no existe";
                    return;
                }
                
                var usuario = db.GetTable<Usuario>().FirstOrDefault(u => u.strNombrePersona == persona.id);
                if (usuario == null)
                {
                    this.lblMensaje.Visible = true;
                    this.lblMensaje.Text = "El correo ingresado no tiene un usuario.";
                    return;
                }
                if (usuario.CatValorUsuario > 1)
                {
                    this.lblMensaje.Visible = true;
                    this.lblMensaje.Text = "El usuario asignado a este correo no está activo";
                    return;
                }
                var token = this.GetSHA256(Guid.NewGuid().ToString());
                usuario.strTokenRecorver = token;
                db.SubmitChanges();
                if (recoveryPasswordEmail(persona.strCorreo, usuario.strUsuario, token))
                {
                    this.lblMensaje.Visible = true;
                    this.lblMensaje.Text = "Por favor verifica tu correo para poder hacer la recuperacion de la cuenta dale click en el link";

                }
                else
                {
                    this.lblMensaje.Visible = true;
                    this.lblMensaje.Text = "Hubo un error al enviar el correo";
                    return;
                }
            }
            catch (Exception ex)
            {

                Response.Redirect("~/ErrorPage.aspx", false);
            }
        }
        public string GetSHA256(string str)
        {
            SHA256 sha256 = SHA256Managed.Create();
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] stream = null;
            StringBuilder sb = new StringBuilder();
            stream = sha256.ComputeHash(encoding.GetBytes(str));
            for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
            return sb.ToString();
        }

        public bool recoveryPasswordEmail(String email, String name, String token)
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                SmtpClient smtpClient = new SmtpClient();
                mailMessage.From = new MailAddress("18300156@uttt.edu.mx");
                mailMessage.To.Add(new MailAddress(email));
                mailMessage.Subject = "Recuerda que te mencione que no te olvidaras de tu contraseña!!! pero vale esta bien vamos a" +
                    "Recuperar tu contraseña aqui";
                mailMessage.IsBodyHtml = true;
                mailMessage.Body = this.enviarCorreo(name, token);
                smtpClient.Port = 587;
                smtpClient.Host = "smtp.gmail.com";
                smtpClient.EnableSsl = true;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential("18300156@uttt.edu.mx", "URG7724U");
                smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpClient.Send(mailMessage);
                return true;
            }
            catch (Exception _e)
            {

                return false;
            }
        }
        private String enviarCorreo(String name, String token)
        {
            String prodUrl = "http://urielo-001-site1.gtempurl.com/Views/RecuperarContraseñaManager.aspx?token=" + token;
            String body = "<h2>Hola Estimado Usuario " + name + "</h2><br>" +
                "<p>¿Restablecer tu contraseña? Has clik en este link para poder recuperar tu contraseña" +
                " </p>" +
                "<a href='" + prodUrl + "'>Link</a>";
            return body;

        }

    }
}