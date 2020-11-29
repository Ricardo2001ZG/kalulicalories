
import 'package:flutter/material.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserProfile.dart';
import 'package:kalulicalories/gui/KaLuLiCaloriesOpeningPage.dart';
import 'package:kalulicalories/gui/KaLuLiCaloriesLoginPage.dart';
import 'package:kalulicalories/gui/KaLuLiCaloriesMainPage.dart';
import 'package:kalulicalories/gui/MainPage/KaLuLiCaloriesBMICalcPage.dart';
import 'package:kalulicalories/gui/MainPage/KaLuLiCaloriesWeightRecordPage.dart';
import 'package:kalulicalories/gui/MainPage/KaLuLiCaloriesMyCaloriesPage.dart';
import 'package:kalulicalories/gui/MainPage/KaLuLiCaloriesFriendsRankPage.dart';
import 'package:kalulicalories/gui/MainPage/KaLuLiCaloriesFriendsManagePage.dart';
import 'package:kalulicalories/gui/MainPage/KaLuLiCaloriesConfigPage.dart';

// 此处为路由实现，处理页面跳转
class KaLuLiCaloriesRoute extends StatefulWidget {
  @override
  _KaLuLiCaloriesRouteState createState() => _KaLuLiCaloriesRouteState();
}

class _KaLuLiCaloriesRouteState extends State<KaLuLiCaloriesRoute> {
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:"/homepage",
      routes:{
        "/homepage":(context) => KaLuLiCaloriesOpeningPage(),
        "/login":(context) => KaLuLiCaloriesLoginPage(),
        "/main":(context) => KaLuLiCaloriesMainPage(),
        "/main/BMICalc":(context) => KaLuLiCaloriesBMICalcPage(),
        "/main/weightRecord":(context) => KaLuLiCaloriesWeightRecordPage(),
        "/main/myCalories":(context) => KaLuLiCaloriesMyCaloriesPage(),
        "/main/FriendsRank":(context) => KaLuLiCaloriesFriendsRankPage(),
        "/main/FriendsManage":(context) => KaLuLiCaloriesFriendsManagePage(),
        "/main/Config":(context) => KaLuLiCaloriesConfigPage(),
      },
    );
  }
}

void main() {
  runApp(KaLuLiCaloriesRoute());
}