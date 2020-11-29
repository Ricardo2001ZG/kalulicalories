
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesConfig.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserProfile.dart';

class KaLuLiCaloriesConfigPage extends StatefulWidget {
  KaLuLiCaloriesConfigPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesConfigPageState createState() =>  _KaLuLiCaloriesConfigPageState();
}

class _KaLuLiCaloriesConfigPageState extends State<KaLuLiCaloriesConfigPage> {

  static Container appBarReturn(BuildContext context, Size size){
    double appBarReturnWidth = 0;
    if(size.width >= 400) {
      appBarReturnWidth = size.width;
    }else if (size.width <= 400) {
      appBarReturnWidth = 360;
    }
    return Container(
      width: appBarReturnWidth,
      height: 130,
      child: Column(children: [
        Container(width: double.infinity, height: 30,), // 空白填充
        Container(
          width: double.infinity,
          height: 90,
          child: Row(children: [
            Expanded(child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Row(children: [
                Container(
                  width: 170,
                  height: double.infinity,
                  child: Column(children: [
                    Row(children: [
                      Container(width: 10,),
                      Stack(children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          color: Color(0x5Effffff),
                          size: 38,
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          child: FlatButton(
                            onPressed: (){
                              Navigator.popAndPushNamed(context, "/main");
                            },
                            child: null,
                          ),
                        ),
                      ],),
                      Expanded(child: Container(height: 38,),),
                    ],),
                    Container(width: double.infinity, height: 5,),
                    Row(children: [
                      Container(width: 20,),
                      Text(
                        "设置",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Hiragino Sans GB", 
                          fontSize: 28,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ],),
                  ],),
                ),
                Expanded(child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),), // 空白填充
              ],),
            ),),
            Container(width: 20, height: double.infinity,), // 空白填充
          ],),
        ),
        Container(width: double.infinity, height: 10,), // 空白填充
      ],),
    );
  }

  static Text dialogTitle(String titleText,){
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

  static TextField singleDialogTextField(
      String hintTextInput,
      TextEditingController _textController,
      ) {
    return TextField(
      // decoration: null,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffffa200)),
        ),
        hintText: hintTextInput,
        hintStyle: TextStyle(
          fontFamily: "Hiragino Sans GB",
          fontSize: 16.0,
          color: Color(0xff9b9b9b),
        ),
      ),
      textAlign: TextAlign.center,
      cursorColor: Color(0xffffa200),
      maxLines: 1,
      // controller: ,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 16.0,
        color: Color(0xff9b9b9b),
      ),
      // keyboardType: TextInputType.number,
      controller: _textController,
    );
  }

  static Text dialogButtonText(String buttonText,){
    return Text(
      buttonText,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 12.0,
        color: Color(0xffFFA200),
      ),
    );
  }

  static void errorRepeatPasswdDialog(BuildContext context,) {
    showDialog(
      context: context,
      builder:  (context) {
        return AlertDialog(
          title: dialogTitle('确认密码错误'),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              Text(
                '您输入的确认密码与新密码不符，请重新检查。',
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

  static void changePasswordDialog(BuildContext context, ){
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController _passwd = new TextEditingController();
          TextEditingController _newPasswd = new TextEditingController();
          TextEditingController _repeatNewPasswd = new TextEditingController();
          return AlertDialog(
            title: dialogTitle('变更密码'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  singleDialogTextField('原密码',_passwd,),
                  singleDialogTextField('新密码',_newPasswd,),
                  singleDialogTextField('确认新密码',_repeatNewPasswd),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: dialogButtonText('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: dialogButtonText('确定'),
                onPressed: () {
                  if (_newPasswd.text != _repeatNewPasswd.text) {
                    errorRepeatPasswdDialog(context);
                  } else if (_newPasswd.text == _repeatNewPasswd.text) {
                    changePasswd(_passwd.text, _newPasswd.text, context);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        }
    );
  }

  static void changeUserNameDialog(BuildContext context, String userName){
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController _newUserName = new TextEditingController();
          return AlertDialog(
            title: dialogTitle('更改用户名称'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  singleDialogTextField(userName, _newUserName,),
                ],
              ),
            ),
            // 下方按钮
            actions: <Widget>[
              FlatButton(
                child: dialogButtonText('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: dialogButtonText('确定'),
                onPressed: () {
                  changeUsername(_newUserName.text, context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static void logoutDialog(BuildContext context,){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: dialogTitle('退出账户登录'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    '请问您确定退出账户登录吗？ ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Hiragino Sans GB",
                      fontSize: 14.0,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            // 下方按钮
            actions: <Widget>[
              FlatButton(
                child: dialogButtonText('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: dialogButtonText('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).popAndPushNamed('/login');
                },
              ),
            ],
          );
        }
    );
  }

  static Stack singleConfigButton(BuildContext context, int whichButton, String buttonText, ){
    return Stack(children: [
      Stack(children: [
        Container(
          height: 50,
          child: Column(children: [
            Expanded(child: Container(),),
            Container(child: Row(children: [
              Container(width: 30,), // 空白填充
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontFamily: "Hiragino Sans GB",
                  fontSize: 18,
                  color: Color(0xffffffff),
                ),
              ),
              Expanded(child: Container(),), // 空白填充
            ],),),
            Expanded(child: Container(),),
          ],),
        ),
        Container(
          width: double.infinity,
          height: 50,
          child: FlatButton(child: null, onPressed: (){
            if(whichButton == 1){
            }else if(whichButton == 2){
              changePasswordDialog(context);
            }else if(whichButton == 3){
              changeUserNameDialog(context, '请输入您的新用户名称');
            }else if(whichButton == 4){
              logoutDialog(context);
            }
          },),
        ),
      ],),
    ],);
  }

  static Divider singleConfigButtonDivider(){
    return Divider(
      indent: 30,
      height: 1,
      color: Color(0xffFFFFFF),
    );
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
        const Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hans',
          countryCode: 'CN',
        ),// Chinese *See Advanced Locales below*
      ],
      title: 'KaLuLiCalories',
      home: Scaffold(
        body: Container(
          width: size.width,
          height: double.infinity,
          child: Stack(children: [
            Stack(children: [
              Container(height: 160,color: Color(0xffFFA200),),
              Column(children: [
                Container(
                  height: 150,
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/FriendsRankPage/topbar.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(height: 10,color: Color(0xffFFA200),),
                Expanded(child: Container(
                  color: Color(0xffFFA200),
                  /*
                  // 弃用此处背景渐变，仅供参考
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFA200), Color(0x5EFFA200)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  */
                ),),
              ],),
            ],),
            Column(children: [
              appBarReturn(context, size),
              Expanded(child: Container(child: Column(children: [
                Row(children: [
                  Container(width: 30,), // 空白填充
                  Text(
                    '账号',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontFamily: "Hiragino Sans GB",
                      fontSize: 20,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Expanded(child: Container(),), // 空白填充
                ],),
                Container(height: 20,), // 空白填充
                Divider(height: 1, color: Color(0xffFFFFFF),),
                singleConfigButton(context, 1, userProfile.popUserName()),
                singleConfigButtonDivider(),
                singleConfigButton(context, 2, '变更密码'),
                singleConfigButtonDivider(),
                singleConfigButton(context, 3, '更改用户名称'),
                singleConfigButtonDivider(),
                singleConfigButton(context, 4, '退出账户登录'),
                singleConfigButtonDivider(),
              ],),),),
              // 测试数据
            ],),
          ],),
        ),
      ),
    );
  }
}