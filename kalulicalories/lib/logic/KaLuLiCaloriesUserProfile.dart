
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';

class KaLuLiCaloriesUserProfile {
  Map<String, dynamic> _userProfile = Map();

  Map<String, dynamic> _tokenToUserProfile(String token) {
    RegExp exp = RegExp(r"(?<=\.)[0-9A-Za-z+/]*(?=\.)");
    String playload = exp.firstMatch(token).group(0);
    playload = String.fromCharCodes(base64Decode(playload));
    Map<String, dynamic> playloadJson = json.decode(playload);
    String aud = playloadJson["aud"];
    playload = null;
    playloadJson = null;
    Map<String, dynamic> userProfileMap = Map();
    userProfileMap["aud"] = aud;
    userProfileMap["token"] = token;
    return userProfileMap;
  }

  Map<String, dynamic> _loadUserProfileFromLocal() {
    Map<String, dynamic> userProfile = Map();
    userProfile["State"] = "Failed";
    if (File('user/UserProfile').existsSync() == true) {
      String base64Data = File('user/UserProfile').readAsStringSync();
      userProfile["State"] = "Succeed";
      String userProfileString = String.fromCharCodes(base64Decode(base64Data));
      Map<String, dynamic> userProfileData = json.decode(userProfileString);
      userProfile["aud"] = userProfileData["aud"];
      userProfile["token"] = userProfileData["token"];
      userProfile["username"] = userProfileData["username"];
    }
    return userProfile;
  }

  void _saveUserProfileToLocal(Map<String, dynamic> userProfile){
    String userProfileData = json.encode(userProfile);
    var bytesData = utf8.encode(userProfileData);
    var base64UserProfile = base64Encode(bytesData);
    if (File('user/UserProfile').existsSync() == true) {
      File userProfile = File('user/UserProfile');
      userProfile.deleteSync();
      userProfile = null;
    }
    File userFile = File('user/UserProfile');
    userFile.writeAsStringSync(base64UserProfile);
    userFile = null;
  }

  void saveUserProfileToLocal() {
    _saveUserProfileToLocal(this._userProfile);
  }

  void loadUserProfileFromLocal() {
    this._userProfile = _loadUserProfileFromLocal();
  }

  void createUserProfile(String username, String token) {
    loadUserProfileFromLocal();
    if (this._userProfile["State"] == "Failed") {
      Map<String, dynamic> userProfileMap = _tokenToUserProfile(token);
      userProfileMap["username"] = username;
      _saveUserProfileToLocal(userProfileMap);
      this._userProfile = _loadUserProfileFromLocal();
    } else {
      this._userProfile["token"] = token;
      _saveUserProfileToLocal(this._userProfile);
    }
  }

  void pushToken(String token) {
    this._userProfile["token"] = token;
  }

  void pushUserName(String username) {
    this._userProfile["username"] = username;
  }

  String popToken() {
    if (this._userProfile["State"] == "Failed") {
      return "Dont_have_token";
    }
    return this._userProfile["token"];
  }

  String popEmail() {
    return this._userProfile["aud"];
  }

  String popUserName() {
    return this._userProfile["username"];
  }

  void updateToken(BuildContext context) async{
    try {
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
      map["Authorization"] = _userProfile["token"];
      map["aud"] = _userProfile["aud"];
      Response response = await dio.post("/api/update_token", data: map,);
      // 正在登录留空
      int updateState = response.data['updateState'];
      if(updateState == 1){
        this._userProfile["token"] = response.data["token"];
        _saveUserProfileToLocal(this._userProfile);
      } else if(updateState == 2) {
        Navigator.popAndPushNamed(context, "/login");
      }
    } catch (e) {
      print(e);
    }
  }
}
