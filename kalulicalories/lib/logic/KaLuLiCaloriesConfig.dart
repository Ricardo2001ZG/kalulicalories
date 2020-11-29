
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserProfile.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

Text dialogTitle(String titleText,){
  return Text(
    titleText,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: "Hiragino Sans GB",
      fontSize: 16.0,
      color: Color(0xff000000),
    ),
  );
}

Text dialogButtonText(String buttonText,){
  return Text(
    buttonText,
    style: TextStyle(
      fontFamily: "Hiragino Sans GB",
      fontSize: 12.0,
      color: Color(0xffFFA200),
    ),
  );
}

void changePasswdDialog(BuildContext context,String title, String text) {
  showDialog(
    context: context,
    builder:  (context) {
      return AlertDialog(
        title: dialogTitle(title),
        content: SingleChildScrollView(
          child: ListBody(children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Hiragino Sans GB",
                fontSize: 14.0,
                color: Color(0xff000000),
              ),
            ),
          ],),
        ),
        actions: [
          FlatButton(
            child: dialogButtonText('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );
}

void changeUsernameDialog(BuildContext context,String title, String text) {
  showDialog(
      context: context,
      builder:  (context) {
        return AlertDialog(
          title: dialogTitle(title),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Hiragino Sans GB",
                  fontSize: 14.0,
                  color: Color(0xff000000),
                ),
              ),
            ],),
          ),
          actions: [
            FlatButton(
              child: dialogButtonText('确定'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.popAndPushNamed(context, "/main/Config");
              },
            ),
          ],
        );
      }
  );
}

String _getPasswordHMAC(String email, String password) {
  List bytes = utf8.encode(password);
  Digest digest = sha256.convert(bytes);
  String passwordSHA256 = digest.toString();
  List key = utf8.encode(email);
  bytes = utf8.encode(passwordSHA256);
  passwordSHA256 = null;
  var hmacSha256Key = new Hmac(sha256, key);
  digest = hmacSha256Key.convert(bytes);
  String passwordHMAC = digest.toString();
  return passwordHMAC;
}

void changePasswd(String _passwd, String _newPasswd,BuildContext context) async{
  try {
    var userProfile = KaLuLiCaloriesUserProfile();
    userProfile.loadUserProfileFromLocal();
    // String url = "https://kalulicaloriesdev.ricardo2001zg.com/api/login";
    Map<String,dynamic> map = Map();
    Dio dio = Dio()
      ..options.baseUrl = "https://kalulicaloriesdev.ricardo2001zg.com/"
      ..httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: 10000,
          /// Ignore bad certificate
          // onClientCreate: (_, clientSetting) => clientSetting.onBadCertificate = (_) => true,
        ),
      );
    map["aud"] = userProfile.popEmail();
    map["password_hmac"] = _getPasswordHMAC(map["aud"], _passwd);
    map["new_password_hmac"] = _getPasswordHMAC(map["aud"], _newPasswd);
    Response response = await dio.post("/api/change_passwd", data: map,);
    if (response.data['changeState'] == 1) {
      changePasswdDialog(context, "修改成功", "您的密码修改成功，请牢记新密码。");
    }else if (response.data['changeState'] == 2) {
      changePasswdDialog(context, "修改失败", "您的原密码有误，请输入正确的密码。");
    }
  } catch (e) {
    print(e);
  }
}

void changeUsername(String _newUsername,BuildContext context) async{
  try {
    var userProfile = KaLuLiCaloriesUserProfile();
    userProfile.loadUserProfileFromLocal();
    // String url = "https://kalulicaloriesdev.ricardo2001zg.com/api/login";
    Map<String,dynamic> map = Map();
    Dio dio = Dio()
      ..options.baseUrl = "https://kalulicaloriesdev.ricardo2001zg.com/"
      ..httpClientAdapter = Http2Adapter(
        ConnectionManager(
          idleTimeout: 10000,
          /// Ignore bad certificate
          // onClientCreate: (_, clientSetting) => clientSetting.onBadCertificate = (_) => true,
        ),
      );
    map["Authorization"] = userProfile.popToken();
    map["aud"] = userProfile.popEmail();
    map["new_username"] = _newUsername;
    Response response = await dio.post("/api/change_username", data: map,);
    if (response.data['changeState'] == 1) {
      userProfile.pushUserName(response.data['username']);
      userProfile.saveUserProfileToLocal();
      changeUsernameDialog(context, "修改成功", "您的用户名称修改成功。");
    }else if (response.data['changeState'] == 2) {
      changeUsernameDialog(context, "修改失败", "您的用户名称修改失败。");
      Navigator.popAndPushNamed(context, "/main");
    }
  } catch (e) {
    print(e);
  }
}