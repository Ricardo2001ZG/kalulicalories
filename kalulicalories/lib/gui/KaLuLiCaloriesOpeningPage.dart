
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';

class KaLuLiCaloriesOpeningPage extends StatefulWidget {
  KaLuLiCaloriesOpeningPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesOpeningPageState createState() =>  _KaLuLiCaloriesOpeningPageState();
}

class _KaLuLiCaloriesOpeningPageState extends State<KaLuLiCaloriesOpeningPage> {

  Timer timer;
  @override
  void initState() {
    super.initState();
    timer =  new Timer(Duration(milliseconds: 1500), (){
      Navigator.popAndPushNamed(context, "/login");
    });
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      /*启用本地化设置，对中文启用支持。*/
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),// Chinese *See Advanced Locales below*
      ],
      title: 'KaLuLiCalories',
      home: Scaffold(body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffffffff),
        child: Row(children: [
          Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
          Container(
            width: 300,
            height: double.infinity,
            child: Column(children: [
              Container(width: double.infinity, height: 100,), // 空白填充
              Container(child: Text(
                "燃烧吧，\n          卡路里！",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Color(0xffcbcbcb),
                  fontFamily: "HYZhuZiXiaoJingLingW",
                  fontSize: 48,
                ),
              ),), // 字体
              Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
              Container(
                width: 70,
                height: 70,
                child: Image.asset('assets/images/logo.png',fit: BoxFit.contain,),
              ),
              Container(width: double.infinity, height: 120,), // 空白填充
            ],),
          ),
          Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
        ],),
      ),),
    );
  }
}