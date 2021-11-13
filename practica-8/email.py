from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
import json
import argparse
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument("--to", dest="to", type=str, help="path del .txt con emails", required=True)
parser.add_argument("--subject", dest="subject", type=str, help="asunto del correo", required=True)
parser.add_argument("--body", dest="body", type=str, help="nombre del script de powershell", required=True)
params = parser.parse_args()

data = {}


def body():
    command = "powershell -ExecutionPolicy ByPass -File {}".format(params.body)
    psResult = subprocess.run(command, stdout=subprocess.PIPE)

    if psResult.stderr == None:

        result = psResult.stdout.splitlines()
        resultchido = [x.decode("utf-8") for x in result]
    return '\n'.join(map(str, resultchido))


def send():
    with open("credentials.json") as f:
        data = json.load(f)

    email_msg = MIMEMultipart()
    email_msg["From"] = data["user"]

    with open(params.to) as c:
        lineas = c.readlines()
        for linea in lineas:
            destinatarios = linea.strip('\n')

            email_msg["To"] = destinatarios
            email_msg["Subject"] = params.subject

            message = body()
            email_msg.attach(MIMEText(message, "plain"))

            server = smtplib.SMTP("smtp.office365.com:587")
            server.starttls()

            server.login(data["user"], data["pass"])
            server.sendmail(email_msg["From"], destinatarios, email_msg.as_string())
            server.quit()
            print("Mensaje enviado🚀🚀🚀", destinatarios)

send()
