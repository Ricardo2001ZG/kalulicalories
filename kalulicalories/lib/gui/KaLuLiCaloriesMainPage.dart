
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserProfile.dart';

class KaLuLiCaloriesMainPage extends StatefulWidget {
  KaLuLiCaloriesMainPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesMainPageState createState() =>  _KaLuLiCaloriesMainPageState();
}

class _KaLuLiCaloriesMainPageState extends State<KaLuLiCaloriesMainPage> {
  static var addCard = 0;
  static var cardState = 1;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static Container addCardColor(int addCardColorNum) {
    if (addCardColorNum == addCard) {
      return Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          color: Color(0x19FFA200),
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
    }
    return Container(width: 150, height: 140, color: Colors.transparent,);
  }

  static Column cardDivider() {
    return Column(children: [
      Expanded(child: Container(width: double.infinity, height: 139,),), // 空白填充
      Divider(
        color: Color(0xffF1F3F8),
        indent: 30, endIndent: 30, height: 1, thickness: 1,
      ),
      Expanded(child: Container(width: double.infinity, height: 140,),), // 空白填充
    ],);
  }

  static Row cardVerticalDivider() {
    return Row(children: [
      Expanded(child: Container(width: 149, height: double.infinity,),), // 空白填充
      VerticalDivider(
        color: Color(0xffF1F3F8),
        indent: 25, endIndent: 25, width: 1, thickness: 1,
      ),
      Expanded(child: Container(width: 150, height: double.infinity,),), // 空白填充
    ],);
  }

  static var _refreshCardColor = RefreshableView(
      builder: (BuildContext context) {
        return Column(children: [
          Row(children: [addCardColor(1), addCardColor(2),],),
          Row(children: [addCardColor(3), addCardColor(4),],),
        ],);
      }
  );

  static Container cardSinglePart(String singlePartText, int addCardInput, Image iconImageInput,) {
    return Container(
      width: 150,
      height: 140,
      child: FlatButton(
        onPressed: (){
          addCard = addCardInput;
          _refreshCardColor.reload();
        },
        child: Container(
          width: 150,
          height: 140,
          child: Column(children: [
            Container(width: double.infinity, height: 30,), // 空白填充
            Container(width: 60, height: 60, child: iconImageInput,),
            Container(width: double.infinity, height: 10,), // 空白填充
            Container(
              width: double.infinity,
              child: Text(
                singlePartText,
                textAlign: TextAlign.center,
                style: new TextStyle(fontFamily: "Hiragino Sans GB", fontSize: 14,),
              ),
            ),
            Container(width: double.infinity, height: 15,), // 空白填充
          ],),
        ),
      ),
    );
  }

  // 卡片内容切换。
  // 1 为 foodCard ，即 “饮食” 页面。
  // 2 为 sportCard，即 “运动” 页面。
  static var _refreshCardChanged = RefreshableView(
      builder: (BuildContext context) {
        if(cardState == 2) {
          return Column(children: [
            Row(children: [
              cardSinglePart("跑步", 1, Image.asset("assets/images/mainPage/sportCard/running.png", fit: BoxFit.fill,),),
              cardSinglePart("骑行", 2, Image.asset("assets/images/mainPage/sportCard/mountain.png", fit: BoxFit.fill,),),
            ],),
            Row(children: [
              cardSinglePart("游泳", 3, Image.asset("assets/images/mainPage/sportCard/swimming.png", fit: BoxFit.fill,),),
              cardSinglePart("球类", 4, Image.asset("assets/images/mainPage/sportCard/basketball.png", fit: BoxFit.fill,),),
            ],),
          ],);
        }
        return Column(children: [
          Row(children: [
            cardSinglePart("早餐", 1, Image.asset("assets/images/mainPage/foodCard/breakfast.png", fit: BoxFit.fill,),),
            cardSinglePart("午餐", 2, Image.asset("assets/images/mainPage/foodCard/lunch.png", fit: BoxFit.fill,),),
          ],),
          Row(children: [
            cardSinglePart("晚餐", 3, Image.asset("assets/images/mainPage/foodCard/dinner.png", fit: BoxFit.fill,),),
            cardSinglePart("加餐", 4, Image.asset("assets/images/mainPage/foodCard/snack.png", fit: BoxFit.fill,),),
          ],),
        ],);
      }
  );

  static Container singleCardButtonBar(
      String buttonName, int cardStateInput,
      Color buttonColor, Color textColor,
      Color borderSideColor,
      ){
    return Container(width: 100, height: double.infinity, child: FlatButton(
      color: buttonColor,
      textColor: textColor,
      child: Text(
        buttonName,
        style: new TextStyle(
          fontFamily: "Hiragino Sans GB",
          fontSize: 14,
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderSideColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: (){
        cardState = cardStateInput;
        _refreshCardChanged.reload();
        _refreshCardButtonBar.reload();
      },
    ),);
  }

  static var _refreshCardButtonBar = RefreshableView(
    builder: (BuildContext context) {
      Color buttonColorLeft = Color(0xffFFFFFF);
      Color textColorLeft = Color(0xffFFA200);
      Color borderSideColorLeft = Color(0xffFFFFFF);
      Color buttonColorRight = Colors.transparent;
      Color textColorRight = Color(0x89000000);
      Color borderSideColorRight = Color(0x89000000);
      if(cardState == 1){
        buttonColorLeft = Color(0xffFFFFFF);
        textColorLeft = Color(0xffFFA200);
        borderSideColorLeft = Color(0xffFFFFFF);
        buttonColorRight = Colors.transparent;
        textColorRight = Color(0x89000000);
        borderSideColorRight = Color(0x89000000);
      }else if(cardState == 2){
        buttonColorLeft = Colors.transparent;
        textColorLeft = Color(0x89000000);
        borderSideColorLeft = Color(0x89000000);
        buttonColorRight = Color(0xffFFFFFF);
        textColorRight = Color(0xffFFA200);
        borderSideColorRight = Color(0xffFFFFFF);
      }
      return Container(width: double.infinity, height: 30, child: Row(children: [
        Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
        singleCardButtonBar("饮食", 1, buttonColorLeft, textColorLeft, borderSideColorLeft),
        Container(width: 20, height: double.infinity,), // 空白填充
        singleCardButtonBar("运动", 2, buttonColorRight, textColorRight, borderSideColorRight),
        Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
      ],),);
    }
  );

  static Container createSidebarButton(
      Image iconInput,
      String buttonText,
      BuildContext context,
      String routeName,
      ) {
    return Container(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        onPressed: (){Navigator.of(context).popAndPushNamed(routeName);},
        child: Row(children: [
          Container(width: 10, height: double.infinity,), // 空白填充
          Container(
            width: 30,
            height: 30,
            child: iconInput,
          ),
          Container(width: 10, height: double.infinity,), // 空白填充
          Container(
            height: 20,
            child: Text(
              buttonText,
              style: new TextStyle(
                fontFamily: "Hiragino Sans GB",
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ),
          Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
        ],),
      ),
    );
  }

  static Text _addRecordDialogText(String dialogText, Color textColor) {
    return Text(
      dialogText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 14.0,
        color: textColor,
      ),
    );
  }

  static Container singleAddRecordImageButton(int whichButton) {
    String buttonText = "";
    Icon buttonIcon = Icon(Icons.camera_alt_outlined, color: Color(0xffFFA200),);
    if (whichButton == 1) {
      buttonText = "拍照上传";
      buttonIcon = Icon(Icons.camera_alt_outlined, color: Color(0xffFFA200),);
    } else if (whichButton == 2) {
      buttonText = "图片上传";
      buttonIcon = Icon(Icons.upload_file, color: Color(0xffFFA200),);
    }
    return Container(
      width: 170,
      height: 35,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                blurRadius: 5.0, //阴影模糊程度
                spreadRadius: 2.0 //阴影扩散程度
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0x19FFA200),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(children: [
            Container(width: 10,), // 空白填充
            buttonIcon,
            Expanded(child: Container(width: double.infinity,),), // 空白填充
            Column(children: [
              Expanded(child: Container(height: double.infinity,),), // 空白填充
              _addRecordDialogText(buttonText, Color(0xff72909D),),
              Expanded(child: Container(height: double.infinity,),), // 空白填充
            ],),
            Expanded(child: Container(width: double.infinity,),), // 空白填充
          ],),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FlatButton(
              child: null,
              onPressed: (){
                
              },
            ),
          ),
        ),
      ],),
    );
  }

  static void _addRecordDialog(
      BuildContext context,
      String dialogTitle,
      )
  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: _addRecordDialogText(dialogTitle, Color(0xff000000)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 100,
                    child: Column(children: [
                      Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
                      singleAddRecordImageButton(1),
                      Container(width: double.infinity, height: 30, ), // 空白填充
                      singleAddRecordImageButton(2),
                      Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
                    ],),
                  ),
                ],
              ),
            ),
            // 下方按钮
            actions: <Widget>[
              FlatButton(
                child: _addRecordDialogText("取消", Color(0xffFFA200)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var userProfile = KaLuLiCaloriesUserProfile();
    userProfile.loadUserProfileFromLocal();
    userProfile.updateToken(context);
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
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Container(
          width: 180,
          height: double.infinity,
          color: Color(0xffFFFFFF),
          child: Column(children: [
            Container(width: double.infinity, height: 85, ), // 空白填充
            createSidebarButton(
              Image.asset("assets/images/mainPage/sidebar/calc.png", fit: BoxFit.contain,),
              "BMI计算器", 
              context,
              "/main/BMICalc",
            ),
            createSidebarButton(
              Image.asset("assets/images/mainPage/sidebar/weight.png", fit: BoxFit.contain,),
              "体重记录",
              context,
              "/main/weightRecord",
            ),
            createSidebarButton(
              Image.asset("assets/images/mainPage/sidebar/record.png", fit: BoxFit.contain,),
              "我的卡路里",
              context,
              "/main/myCalories",
            ),
            createSidebarButton(
              Image.asset("assets/images/mainPage/sidebar/friends.png", fit: BoxFit.contain,),
              "好友排行榜",
              context,
              "/main/FriendsRank",
            ),
            createSidebarButton(
              Image.asset("assets/images/mainPage/sidebar/config.png", fit: BoxFit.contain,),
              "设置",
              context,
              "/main/Config",
            ),
          ],),
        ),
        body: Container(
          width: size.width,
          height: double.infinity,
          color: Color(0xffffffff),
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 500,
              child: Stack(children: [
                Container(
                  width: double.infinity,
                  height: 270,
                  child: Image.asset("assets/images/mainPage/background/topbar.png", fit: BoxFit.fill,),
                ),
                Column(children: [
                  Container(width: double.infinity, height: 40,), // 空白填充
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Row(children: [
                      Container(
                        width: 60,
                        height: 50,
                        child: FlatButton(
                          child: Icon(Icons.dehaze, color: Color(0xffffffff),),
                          onPressed: (){_scaffoldKey.currentState.openDrawer();},
                        ),
                      ),
                      Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
                    ],),
                  ),
                ],),
                Row(children: [
                  Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
                  Container(
                    width: 300,
                    height: 500,
                    child: Column(children: [
                      Container(width: double.infinity, height: 95,),
                      _refreshCardButtonBar,
                      Container(width: double.infinity, height: 35,), // 空白填充
                      Container(width: double.infinity, child: Text(
                        "Burning Calories!",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          fontFamily: "Helvetica",
                          fontSize: 24,
                          color: Color(0xffffffff),
                        ),
                      ),),
                      Container(width: double.infinity, height: 35,), // 空白填充
                      Container(
                        width: 300,
                        height: 280,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                                blurRadius: 5.0, //阴影模糊程度
                                spreadRadius: 2.0 //阴影扩散程度
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(children: [
                            cardDivider(),
                            cardVerticalDivider(),
                            _refreshCardColor,
                            _refreshCardChanged,
                            Column(children: [
                              Container(width: double.infinity, height: 100,), // 空白填充
                              Container(
                                width: 80,
                                height: 80,
                                child: RaisedButton(
                                  color: Color(0xffFFA200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  child: Icon(Icons.add, color: Color(0xffffffff), size: 48,),
                                  onPressed: (){
                                    _addRecordDialog(context, "上传记录");
                                  },
                                ),
                              ),
                              Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
                            ],),
                          ],),
                        ),
                      ),
                    ],),
                  ),
                  Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
                ],),
              ],),
            ),
            Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
            Container(
              width: double.infinity,
              height: 300,
              child: Image.asset("assets/images/mainPage/background/footer.png", fit: BoxFit.fill,),
            ),
          ],),
        ),
      ),
    );
  }
}