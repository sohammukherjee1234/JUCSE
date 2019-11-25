import poplib
import email
import getpass
import smtplib
import email.utils
from email.mime.text import MIMEText

def send_ack(receiver):
    username = 'sohamantipro@gmail.com'
    password = 'rueaxtremlxbouzw''
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.ehlo()
    server.starttls()
    server.login(username,password)

    # Create the message
    msg = MIMEText("Opened the mail")
    msg['To'] = email.utils.formataddr(('User', receiver))
    msg['From'] = email.utils.formataddr(('Soham', username))
    msg['Subject'] = "Acknowledgement"
    

    try:
        server.sendmail(username, [msg['To']], msg.as_string())
    finally:
        server.quit()

pop_conn = poplib.POP3_SSL('pop.gmail.com', 995)
#pop_conn.user(input("insert Email : "))
#pop_conn.pass_(getpass.getpass("password : "))

username1 = 'sohamantipr000@gmail.com'
password1 = 'ifrxsuspiwvmhbiv'

username2 = 'sohamantipro@gmail.com'
password2 = 'rueaxtremlxbouzw'
pop_conn.user(username2)
pop_conn.pass_(password2)

print(pop_conn.stat())
print(pop_conn.list())
print ("")

if pop_conn.stat()[1] > 0:
    print ("You have new emails. Do you want to read them? (y/n)")
    key = input()
    if key == "y" or key=="Y":
        numMessages = len(pop_conn.list()[1])
        for i in range(numMessages):
            receipient = ""
            for j in pop_conn.retr(i+1)[1]:
                if j.startswith(b'From'):
                    receipient = j.decode("utf-8").split('<')[1].split('>')[0]
                    
                if j.startswith(b'Subject'):
                    print(j)
                    subjectmsg = j.decode("utf-8").split(" ")[1]
                    if subjectmsg != "Acknowledgement":
                        send_ack(receipient)
                    else:
                        print("Acknowledgement message. Not sending an acknowledgement to this")
                msg = email.message_from_string(j.decode("utf-8"))
                strtext=msg.get_payload()
                print (strtext)
    
else:
    print ("No new mail.")
print ("")


        

pop_conn.quit()
input("Press any key to continue.")
