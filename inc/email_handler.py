import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from inc.mailsender import MailSender

# ON network Email
Email = 'on.iot.iq@gmail.com'
password = 'kuuaxamejwxtmqua'

# Admin Email
adminEmail='Alifalih783783@gmail.com'

#send Registeration Verification Email.
def sendRVE(username,userEmail,host,code):
    images = list()
    images.append({
        'id': 'logo',
        'path': './local/images/logo.png'
    })

    with open('./emails/RVE.html') as template_html:
        message_html = template_html.read().replace('myhost',host).replace('myusername',username).replace('mycode',code)
        mail_sender = MailSender(Email, password)
        mail_sender.send(Email, [userEmail], 'ON Verification', message_html=message_html, images=images)

#send password reset Email.
def sendPRE(username,userEmail,host,code):
    images = list()
    images.append({
        'id': 'logo',
        'path': './local/images/logo.png'
    })
    with open('./emails/PRE.html') as template_html:
        message_html = template_html.read().replace('myhost',host).replace('myusername',username).replace('mycode',code)
        mail_sender = MailSender(Email, password)
        mail_sender.send(Email, [userEmail], 'ON Password Reset', message_html=message_html, images=images)

# send error logging email to the admin email
def sendELE(error):
    mail_sender = MailSender(Email, password)
    mail_sender.send(Email, [adminEmail], 'ON Error', message_html=error)
