# -*- coding: UTF-8 -*-
import time
import base64
import urllib.parse
import urllib.request
import urllib.error
import hashlib
import json
url_prefix = "https://api.ai.qq.com/fcgi-bin/"


def set_params(array, key, value):
    array[key] = value


def gen_sign_string(parser):
    uri_str = ''
    for key in sorted(parser.keys()):
        if key == 'app_key':
            continue
        uri_str += "%s=%s&" % (key, urllib.parse.quote(str(parser[key]), safe=''))
    sign_str = uri_str + 'app_key=' + parser['app_key']
    hash_md5 = hashlib.md5(sign_str.encode("utf-8"))
    return hash_md5.hexdigest().upper()


class ImageTag(object):
    def __init__(self, app_id, app_key):
        self.app_id = app_id
        self.app_key = app_key
        self.url = ""
        self.url_data = ""
        self.data = {}

    def invoke(self, params):
        del(params['app_key'])
        self.url_data = urllib.parse.urlencode(params)
        self.url_data = bytes(self.url_data, encoding="utf8")
        req = urllib.request.Request(self.url, self.url_data)
        try:
            rsp = urllib.request.urlopen(req)
            str_rsp = rsp.read()
            dict_rsp = json.loads(str_rsp)
            return dict_rsp
        except urllib.error.URLError as e:
            dict_error = {}
            if hasattr(e, "code"):
                dict_error = {'ret': -1, 'http_code': e.code, 'msg': "sdk http post err"}
                return dict_error
            if hasattr(e, "reason"):
                dict_error['msg'] = 'sdk http post err'
                dict_error['http_code'] = -1
                dict_error['ret'] = -1
                return dict_error

    def image_tag(self, image):
        self.url = url_prefix + 'image/image_tag'
        set_params(self.data, 'app_id', self.app_id)
        set_params(self.data, 'app_key', self.app_key)
        set_params(self.data, 'time_stamp', int(time.time()))
        set_params(self.data, 'nonce_str', int(time.time()))
        image_data = str(base64.b64encode(image), encoding='utf-8')
        set_params(self.data, 'image', image_data)
        sign_str = gen_sign_string(self.data)
        set_params(self.data, 'sign', sign_str)
        return self.invoke(self.data)
