# -*- coding: UTF-8 -*-
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.header import Header
from email.utils import formataddr


class KalulicaloriesServerSMTP:
    def __init__(self, email_config):
        self.email_config = email_config

    def send_captcha_email(self):
        email_config = self.email_config
        mail_host = email_config['server_smtp_address']
        mail_port = int(email_config['server_smtp_port'])

        mail_user = email_config['server_address']
        mail_pass = email_config['server_password']

        sender = mail_user
        receivers = [email_config['client_address']]

        message = MIMEMultipart('alternative')
        message['From'] = formataddr(("noreply@kalulicalories.com", sender))
        message['To'] = formataddr((email_config['client_username'], email_config['client_address']))
        message['Subject'] = '您的 卡路里Calories 账号：更改密码'
        message_text = '''<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
                <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
            </head>
            <body LINK="#c6d4df" ALINK="#c6d4df" VLINK="#c6d4df" TEXT="#c6d4df" 
            style="font-family: Helvetica, Arial, sans-serif; font-size: 14px; color: #c6d4df;" >
            <table style="width: 600px; background-color: #FFA200;" align="center" cellspacing="0" cellpadding="0">
            <tr>
                <td style=" height: 100px; background-color: #FFFFFF; border-bottom: 1px solid #c4bdb2;">
                <img src="https://kalulicaloriesdev.ricardo2001zg.com/kalulicalories_email_header_logo.png" width="600" height="100" alt="Steam">
                </td>
            </tr>
            </table>
            </tr>
            <tr>
                <td bgcolor="#FFFFFF">
                <br>
                    <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" 
                    style="padding-left: 5px; padding-right: 5px; padding-bottom: 10px;
                    box-shadow:0 0 10px rgba(0, 0, 0, 0.116);">
                    <tr><td style="padding-top: 50px;"></td></tr>
                    <tr>
                        <td style="padding: 20px; font-size: 12px; line-height: 17px; color: rgb(140, 140, 140); 
                        font-family: Arial, Helvetica, sans-serif;">
                        <span style="padding-top: 16px; padding-bottom: 16px; font-size: 24px; color: #FFA200; 
                        font-family: Arial, Helvetica, sans-serif; font-weight: bold;">
                            ''' + email_config_data['client_username'] + '''，您好！
                        </span>
                        <br>
                        <span style="font-size: 17px; color: #727a80; 
                        font-family: Arial, Helvetica, sans-serif; font-weight: bold;">
                            <p>您用于账户 ''' + email_config_data['client_address'] + ''' 的验证码为：</p>
                        </span>
                        <br>
                        <span style="font-size: 24px; color: #FFA200; 
                        font-family: Arial, Helvetica, sans-serif; font-weight: bold;">''' \
                        + email_config_data['client_captcha'] + '''</span>
                        <br><br><br>
                        <p style="padding-bottom: 10px; color:rgb(140, 140, 140);">此邮件由系统自动生成。会发送给您，
                            是因为您的账户在
                            <a style="color:rgb(140, 140, 140);" href="https://www.kalulicalories.com">卡路里 Calories</a>
                            应用上提交了忘记密码并重置密码的申请，且提供了该账户对应的邮箱。</p>
                        <p style="padding-bottom: 10px; color:rgb(140, 140, 140);">重置密码必须使用该验证码，
                        <span style="color:rgb(140, 140, 140); font-weight: bold;">
                            除此以外包括工作人员在内无法通过其他方式修改您的密码。
                        </span></p>
                        <p style="padding-bottom: 10px; color:rgb(140, 140, 140);">
                            <span style="color:rgb(140, 140, 140); font-weight: bold;">
                                如果您未曾进行此类行为，则您的账号有被盗的风险。
                            </span>
                            请考虑更新您的 卡路里 Calories 账户密码与更新电子邮箱密码。
                        </p>
                        <p style="padding-bottom: 10px; color:rgb(140, 140, 140);">
                            卡路里 Calories<br />
                            <a style="color: #8f98a0;" href="https://www.kalulicalories.com">
                            https://www.kalulicalories.com</a>
                        </p>
                        <p style="padding-bottom: 10px; color:rgb(140, 140, 140);"></p>
                    </td>
            </tr>
            </table>
        </body>
        </html>
        '''
        message.attach(MIMEText(message_text, 'html', 'utf-8'))
        message_text = '''
        Ricardo2001zg ，您好！\n
        您用于账户 miao@ricardo2001zg.moe 的验证码为：\n
        4DV9X\n
        此邮件由系统自动生成。会发送给您，是因为您的账户在 卡路里 Calories 应用上提交了忘记密码并重置密码的申请，
        且提供了该账户对应的邮箱。\n
        重置密码必须使用该验证码，除此以外包括工作人员在内无法通过其他方式修改您的密码。\n
        如果您未曾进行此类行为，则您的账号有被盗的风险。\n
        请考虑更新您的 卡路里 Calories 账户密码与更新电子邮箱密码。\n
        卡路里 Calories\n
        https://www.kalulicalories.com\n
        '''
        message.attach(MIMEText(message_text, 'plain', 'utf-8'))

        result = False
        # noinspection PyBroadException
        try:
            send_server = smtplib.SMTP_SSL(mail_host, mail_port)
            send_server.login(mail_user, mail_pass)
            send_server.sendmail(sender, receivers, message.as_string())
            send_server.quit()
            result = True
        except Exception as e:
            result = False
            print(e)
        if result:
            print("send succeed")
        else:
            print("send failed")
        # email_config['client_captcha'] = captcha
        # email_config['client_address'] = results[0]  # debug
        # email_config['client_username'] = results[0]  # debug