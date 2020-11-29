
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserLogInAndOut.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesUserProfile.dart';

class KaLuLiCaloriesLoginPage extends StatefulWidget {
  KaLuLiCaloriesLoginPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesLoginPageState createState() =>  _KaLuLiCaloriesLoginPageState();
}

class _KaLuLiCaloriesLoginPageState extends State<KaLuLiCaloriesLoginPage> {

  FocusNode _userFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _userController;
  TextEditingController _passwordController;
  var _userProfile = KaLuLiCaloriesUserProfile();

  void initState() {
    super.initState();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _userProfile.loadUserProfileFromLocal();
    if (_userProfile.popToken() != "Dont_have_token") {
      _userController.text = _userProfile.popEmail();
    }
  }

  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  static TextField singleLoginTextField(
    String hintTextInput,
    TextEditingController _loginController,
    FocusNode textFieldFocusNode,
    bool ifPassword,
  ){
    return TextField(
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
      cursorColor: Color(0xffffa200),
      maxLines: 1,
      // controller: ,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 16.0,
        color: Color(0xff9b9b9b),
      ),
      controller: _loginController,
      focusNode: textFieldFocusNode,
      obscureText: ifPassword,
    );
  }

  Widget build (BuildContext context) {
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xffffffff),
          child: Row(children: [
            Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
            Container(
              width: 300,
              height: double.infinity,
              child: Column(children: [
                Container(width: double.infinity, height: 70,), // 空白填充
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/logo.png',fit: BoxFit.contain,),
                ),
                Container(width: double.infinity, height: 10,), // 空白填充
                Container(
                  width: double.infinity,
                  child: Text(
                    "登录",
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontFamily: "Hiragino Sans GB",
                      fontSize: 32,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 60,
                  child: singleLoginTextField('请输入你的邮箱', _userController, _userFocusNode, false),
                ),
                Container(width: double.infinity, height: 10,), // 空白填充
                Container(
                  width: 300,
                  height: 60,
                  child: singleLoginTextField('请输入密码', _passwordController, _passwordFocusNode, true),
                ),
                Container(width: double.infinity, height: 40,), // 空白填充
                Container(
                  width: 290,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffFF9815), Color(0xffFFC92F)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: RaisedButton(
                    color: Colors.transparent,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    child: Text(
                      "登录",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 16,
                        color: Color(0xffffffff),
                      ),
                    ),
                    onPressed: (){
                      // 安全起见，此处释放焦点，否则激活键盘状态下跳转 mainPage ，
                      // 会导致 mainPage 溢出。
                      _userFocusNode.unfocus();
                      _passwordFocusNode.unfocus();
                      KaLuLiCaloriesUserLogInAndOut.login(
                        _userController.text,
                        _passwordController.text,
                        context,
                      );
                    },
                  ),
                ),
                Container(width: double.infinity, height: 20,), // 空白填充
                Container(
                  width: 100,
                  child: FlatButton(
                    child: Text(
                      "忘记密码?",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 14,
                        color: Color(0xff9b9b9b),
                      ),
                    ),
                    onPressed: (){},
                  ),
                ),
              ],),
            ),
            Expanded(child: Container(width: double.infinity, height: double.infinity,),), // 空白填充
          ],),
        ),
      ),
    );
  }
}