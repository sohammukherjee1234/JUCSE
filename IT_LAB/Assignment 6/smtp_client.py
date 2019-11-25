import smtplib
import email.utils
from email.mime.text import MIMEText
import getpass

username = 'sohamantipr000@gmail.com'
password = 'ifrxsuspiwvmhbiv'
server = smtplib.SMTP('smtp.gmail.com:587')
server.ehlo()
server.starttls()
server.login(username,password)

# Create the message


msg = MIMEText(input("Enter body of mail : "))
msg['To'] = email.utils.formataddr(('Recipient', input("Enter email address of receiver : ")))
msg['From'] = email.utils.formataddr(('Soham', username))
msg['Subject'] = input("Enter subject of mail : ")

try:
    server.sendmail(username, [msg['To']], msg.as_string())
finally:
    server.quit()
