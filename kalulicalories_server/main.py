# -*- coding: UTF-8 -*-

# from flask import Flask
# from flask import request
# from flask import jsonify
from flask import Flask, jsonify, request
import hashlib
import hmac
import mariadb
import sys
import time
import base64
import random
import re
import ast
import json

from typing import List

import tencent_ap_open_platform_sdk as sdk

app = Flask(__name__)


# 测试函数，测试服务器是否启动。
# 生产环境请勿忘记注释。
@app.route('/test')
def https_test():
    return 'HTTPS TEST'


# 判断 email 是否已被注册，并执行注册
def register_state(email, username, password_hmac):
    cur.execute('SELECT * FROM user WHERE email = %s', (email,))
    results = cur.fetchall()
    # registerState 为注册状态码。
    # 1 为 成功注册
    # 2 为 账户已存在
    if results:
        return jsonify({"registerState": 2})
    else:
        cur.execute('INSERT INTO user (email, username, password_hmac) VALUES (%s, %s,%s)',
                    (email, username, password_hmac,))
        conn.commit()
        return jsonify({"registerState": 1})


# 手动注册函数。
# 生产环境请勿忘记注释。
# @app.route('/register_server$email=<email>$username=<username>$password=<password>')
# def register_server(email, username, password):
#     password_sha256 = hashlib.sha256()
#     password_sha256.update(password.encode(encoding='utf-8'))
#     password_hmac_key = bytes(email, encoding='utf-8')
#     password_hmac_message = password_sha256.hexdigest().encode(encoding='utf-8')
#     password_hmac = hmac.new(password_hmac_key, password_hmac_message, digestmod='sha256')
#     password_hmac = password_hmac.hexdigest()
#     return register_state(email, username, password_hmac)


# 注册 API，客户端以 POST 方式提交 json。
# 客户端 json 参数： username ， password_crypto 。
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    email = data['email']
    username = data['username']
    password_hmac = data['password_crypto']
    return register_state(email, username, password_hmac)


def __get_username(email):
    cur.execute('SELECT * FROM user WHERE email = %s', (email,))
    results = cur.fetchall()
    results = list(results[0])
    username = results[1]
    return username


# 授权类函数
class Token:
    # token 类
    # 遵循 JWT (json web token) 标准
    # header 部分:
    # # typ : 声明类型
    # # alg : 加密算法
    # playload 部分:
    # # aud : 用户名
    # # iat : token 签发时间
    # # exp : token 过期时间
    # signature 部分:
    # # base64(header) + "." + base64(payload)
    # # 对上部字符串进行 alg 内的算法加密。
    # # 本项目采用 salt + HMACSha256 ，salt 为时间戳加随机 int 取整后 sha256。
    # # salt 存储于 kalulicalories.token 表的 salt 栏。
    __token = ""

    @staticmethod
    def __create_token(email):
        # 此函数应仅限 get_token 函数调用。
        header = json.dumps({"typ": "JWT", "alg": "HMACSha256"})
        aud = email
        iat = time.time()
        exp = str(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(iat + 15 * 60)))
        iat = str(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(iat)))
        playload = json.dumps({"aud": aud, "iat": iat, "exp": exp})
        base64_header = base64.b64encode(bytes(header, encoding="utf8")).decode("utf-8")
        base64_playload = base64.b64encode(bytes(playload, encoding="utf8")).decode("utf-8")
        signature = str(base64_header + "." + base64_playload).encode("utf-8")
        salt = str(round(time.time() + random.randint(1, 1000000)))
        salt_sha256 = hashlib.sha256()
        salt_sha256.update(salt.encode(encoding='utf-8'))
        salt = salt_sha256.hexdigest()
        cur.execute('INSERT INTO token (email, salt) VALUES (%s,%s)', (email, salt,))
        conn.commit()
        salt = bytes(salt, encoding="utf8")
        signature = hmac.new(salt, signature, digestmod='sha256').hexdigest()
        header = base64.b64encode(bytes(header, encoding="utf8")).decode("utf-8")
        playload = base64.b64encode(bytes(playload, encoding="utf8")).decode("utf-8")
        token = header + "." + playload + "." + signature
        return token

    @staticmethod
    def __delete_token(email):
        cur.execute('DELETE FROM token WHERE email = (%s)', (email,))
        conn.commit()

    @staticmethod
    def __if_have_token(email):
        cur.execute('SELECT * FROM token WHERE email = %s', (email,))
        results = cur.fetchall()
        if results:
            return True
        else:
            return False

    @staticmethod
    def __if_expired_token(token):
        base64_playload = re.search("(?<=\.)[0-9A-Za-z+/]*(?=\.)", token).group(0)
        playload = str(base64.b64decode(base64_playload.encode("utf-8")), encoding="utf-8")
        playload = ast.literal_eval(playload)
        exp = playload['exp']
        exp = round(time.mktime(time.strptime(exp, "%Y-%m-%d %H:%M:%S")))
        time_now = round(time.time())
        if time_now < exp:
            return True
        return False

    @staticmethod
    def __if_sign_token(token):
        base64_header = re.search("[0-9A-Za-z+/=]*(?=\.)", token).group(0)
        base64_playload = re.search("(?<=\.)[0-9A-Za-z+/=]*(?=\.)", token).group(0)
        client_signature = token[token.rfind(".") + 1:len(token)]
        playload = str(base64.b64decode(base64_playload.encode("utf-8")), encoding="utf-8")
        playload = ast.literal_eval(playload)
        aud = playload['aud']
        cur.execute('SELECT * FROM token WHERE email = %s', (aud,))
        results = cur.fetchall()
        salt = list(results[0])[1]
        server_signature = str(base64_header + "." + base64_playload).encode("utf-8")
        salt = bytes(salt, encoding="utf8")
        server_signature = hmac.new(salt, server_signature, digestmod='sha256').hexdigest()
        if server_signature == client_signature:
            return True
        return False

    # login 函数用，获取 token 入口。
    def get_token(self, email):
        if self.__if_have_token(email):
            self.__delete_token(email)
            return self.__create_token(email)
        else:
            return self.__create_token(email)

    def check_token(self, token):
        base64_playload = re.search("(?<=\.)[0-9A-Za-z+/=]*(?=\.)", token).group(0)
        playload = str(base64.b64decode(base64_playload.encode("utf-8")), encoding="utf-8")
        playload = ast.literal_eval(playload)
        aud = playload['aud']
        if self.__if_have_token(aud):
            if self.__if_expired_token(token):
                if self.__if_sign_token(token):
                    return True
                else:
                    return False
            else:
                return False
        else:
            return False

    def push_token(self, token):
        self.__token = token

    def pop_token(self):
        token = self.__token
        return token

    def update_token(self, email):
        if self.__if_have_token(email):
            if self.__if_sign_token(self.__token):
                self.__delete_token(email)
                self.__token = self.__create_token(email)
                return True
            else:
                return False
        else:
            return False


@app.route('/check_token_debug', methods=['POST'])
def check_token_debug():
    data = request.get_json()
    token = Token()
    token.push_token(data['token'])
    print(token.check_token(token.pop_token()))
    return jsonify({"checkState": 1, "desc": "测试成功"})


# 登录 API，客户端以 POST 方式提交 json。
# 客户端 json 参数： username ， password_crypto 。
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data['email']
    password_hmac = data['password_crypto']
    cur.execute('SELECT * FROM user WHERE email = %s', (email,))
    results = cur.fetchall()
    # loginState 为登录状态码。
    # 1 为 成功登录
    # 2 为 密码错误
    # 3 为 账号不存在
    if results:
        results = list(results[0])
        if password_hmac == results[2]:
            token = Token()
            username = __get_username(email)
            return jsonify({"loginState": 1, "desc": "成功登陆", "token": token.get_token(email), "username": username, })
        else:
            return jsonify({"loginState": 2, "desc": "密码错误"})
    return jsonify({"loginState": 3, "desc": "账号不存在"})


@app.route('/update_token', methods=['POST'])
def update_token():
    data = request.get_json()
    email = data["aud"]
    token = Token()
    token.push_token(data["Authorization"])
    if token.update_token(email):
        return jsonify({"updateState": 1, "token": token.pop_token()})
    else:
        return jsonify({"updateState": 2})


@app.route('/change_passwd', methods=['POST'])
def change_passwd():
    data = request.get_json()
    email = data['aud']
    password_hmac = data['password_hmac']
    new_password_hmac = data['new_password_hmac']
    cur.execute('SELECT * FROM user WHERE email = %s', (email,))
    results = cur.fetchall()
    if results:
        results = list(results[0])
        if password_hmac == results[2]:
            print(new_password_hmac)
            cur.execute('UPDATE user SET password_hmac = %s WHERE email = %s',
                        (new_password_hmac, email,))
            conn.commit()
            return jsonify({"changeState": 1, "desc": "修改成功", })
        else:
            return jsonify({"changeState": 2, "desc": "密码错误", })
    return jsonify({"changeState": 3, "desc": "账号不存在"})


@app.route('/forget_passwd', methods=['POST'])
def forget_passwd():
    data = request.get_json()
    email = data['email']
    cur.execute('SELECT * FROM user WHERE email = %s', (email,))
    results = cur.fetchall()
    # updateState 为更新状态码。
    # 1 为 存在用户，发送随机验证码
    # 2 为 账户已存在
    if results:
        results = list(results[0])
        captcha_list = random.sample("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", 4)
        captcha = ""
        for i in captcha_list:
            captcha = captcha + i
        email_config['client_captcha'] = captcha
        email_config['client_address'] = results[0]
        email_config['client_username'] = results[1]
        return jsonify({"updateState": 1, "desc": "验证码已发送"})
    else:
        return jsonify({"updateState": 2, "desc": "用户不存在"})


@app.route('/change_username', methods=['POST'])
def change_username():
    data = request.get_json()
    token = Token()
    token.push_token(data['Authorization'])
    aud = data['aud']
    new_username = data['new_username']
    if token.check_token(token.pop_token()):
        cur.execute('UPDATE user SET username = %s WHERE email = %s',
                    (new_username, aud,))
        conn.commit()
        return jsonify({"changeState": 1, "username": new_username, "desc": "修改成功", })
    else:
        return jsonify({"changeState": 2, "desc": "授权失败", })


@app.route('/image_tag')
def image_tag():
    sdk_image = sdk.ImageTag("请查看腾讯APi调用文档", "授权码")
    img = open('dinner.png', 'rb')
    img_data = img.read()
    img.close()
    sdk_result = sdk_image.image_tag(img_data)
    del img_data
    return jsonify({"state": 0, "data": sdk_result})


def count_friends(results):
    friends_list = []
    friends_dict = {'num': 0, 'list': friends_list, }
    if results:
        for i in results:
            friends_list.append(List[i][0])
            friends_dict['num'] += 1
        friends_dict['list'] = friends_list
        return friends_dict
    else:
        return friends_dict


class Friends:
    @staticmethod
    def __add_friend_apply(from_who, to_who):
        cur.execute('SELECT * FROM friends WHERE from_who = %s AND to_who = %s', (from_who, to_who))
        results = cur.fetchall()
        if results:
            return False
        else:
            cur.execute('INSERT INTO friends (from_who, to_who, state) VALUES (%s, %s, %s)',
                        (from_who, to_who, 1,))
            conn.commit()
            return True

    @staticmethod
    def __accept_friend_apply(from_who, to_who):
        cur.execute('SELECT * FROM friends WHERE from_who = %s AND to_who = %s', (from_who, to_who))
        results = cur.fetchall()
        if results:
            return False
        else:
            cur.execute('UPDATE friends SET state = 2 WHERE from_who = %s AND to_who = %s', (from_who, to_who,))
            conn.commit()
            cur.execute('DELETE FROM friends WHERE from_who = %s AND to_who = %s', (from_who, to_who,))
            conn.commit()
            cur.execute('INSERT INTO friends (from_who, to_who, state) VALUES (%s, %s,%s)', (to_who, from_who, 2,))
            conn.commit()
            return True

    @staticmethod
    def __delete_friend(from_who, to_who):
        cur.execute('SELECT * FROM friends WHERE from_who = %s AND to_who = %s', (from_who, to_who))
        results = cur.fetchall()
        if results:
            return False
        else:
            cur.execute('DELETE FROM friends WHERE from_who = %s AND to_who = %s', (from_who, to_who,))
            conn.commit()
            cur.execute('DELETE FROM friends WHERE from_who = %s AND to_who = %s', (to_who, from_who,))
            conn.commit()
            return True

    @staticmethod
    def __list_friends(aud):
        cur.execute('SELECT * FROM friends WHERE to_who = %s AND state = 2', (aud,))
        return count_friends(cur.fetchall())

    @staticmethod
    def __list_friends_apply(aud):
        cur.execute('SELECT * FROM friends WHERE to_who = %s AND state = 1', (aud,))
        return count_friends(cur.fetchall())

    def add_friend_apply(self, from_who, to_who):
        return self.__add_friend_apply(from_who, to_who)

    def accept_friend_apply(self, from_who, to_who):
        return self.__accept_friend_apply(from_who, to_who)

    def delete_friend(self, from_who, to_who):
        return self.__delete_friend(from_who, to_who)

    def list_friends(self, aud):
        return self.__list_friends(aud)

    def list_friends_apply(self, aud):
        return self.__list_friends_apply(aud)


if __name__ == '__main__':
    email_config = {
        'server_address': '发送端邮箱地址',
        'server_password': '发送端邮箱访问密码',
        'server_pop_address': 'pop.qq.com',
        'server_pop_port': '995',
        'server_smtp_address': 'smtp.qq.com',
        'server_smtp_port': '465',
    }
    try:
        conn = mariadb.connect(
            user="kalulicalories_server_dev 请开发者自行修改",
            password="kalulicalories_dev 请开发者自行修改",
            host="127.0.0.1",
            port=3306,
            database="kalulicalories"
        )
        print('connect success')
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB Platform: {e}")
        sys.exit(1)
    cur = conn.cursor()

    app.config['JSON_AS_ASCII'] = False
    app.run(
        host='此处填写域名(https证书对应的域名)',
        port=15443,
        ssl_context=(
            "https crt 文件",
            "https key 文件",
        ),
        debug=True,
    )
