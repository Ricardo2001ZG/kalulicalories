
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserProfile.dart';

class KaLuLiCaloriesUserLogInAndOut {

  static Text _dialogTitle(String titleText,){
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

  static Text _dialogButtonText(String buttonText,){
    return Text(
      buttonText,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 12.0,
        color: Color(0xffFFA200),
      ),
    );
  }

  static void _loginFailedDialog(BuildContext context,String dialogText){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: _dialogTitle(dialogText),
            // 下方按钮
            actions: <Widget>[
              FlatButton(
                child: _dialogButtonText('确定'),
                onPressed: () {Navigator.of(context).pop();},
              ),
            ],
          );
        }
    );
  }

  static String _getPasswordHMAC(String email, String password) {
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

  static Future<void> login(String email, String password, BuildContext context) async {
    try {
      // String url = "https://kalulicaloriesdev.ricardo2001zg.com/api/login";
      Dio dio = new Dio()
        ..options.baseUrl = "https://kalulicaloriesdev.ricardo2001zg.com/"
        ..httpClientAdapter = Http2Adapter(
          ConnectionManager(
            idleTimeout: 10000,
            /// Ignore bad certificate
            // onClientCreate: (_, clientSetting) => clientSetting.onBadCertificate = (_) => true,
          ),
        );
      Map<String,dynamic> map = Map();
      map['email']=email;
      map['password_crypto']=_getPasswordHMAC(email, password);
      Response response = await dio.post("/api/login", data: map);
      // 正在登录留空
      int loginState = response.data['loginState'];
      if(loginState == 1){
        String token = response.data['token'];
        String username = response.data['username'];
        var userProfile = KaLuLiCaloriesUserProfile();
        userProfile.createUserProfile(username, token);
        Navigator.popAndPushNamed(context, "/main");
        userProfile = null;
      } else if(loginState == 2) {
        _loginFailedDialog(context, '密码错误');
      } else if(loginState == 3) {
        _loginFailedDialog(context, '账号不存在');
      }
      // print(response.data.toString());
    } catch (e) {
      print(e);
    }
  }
}