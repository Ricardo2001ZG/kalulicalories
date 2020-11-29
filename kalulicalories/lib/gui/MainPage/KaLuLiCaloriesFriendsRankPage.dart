
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';

class KaLuLiCaloriesFriendsRankPage extends StatefulWidget {
  KaLuLiCaloriesFriendsRankPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesFriendsRankPageState createState() =>  _KaLuLiCaloriesFriendsRankPageState();
}

class _KaLuLiCaloriesFriendsRankPageState extends State<KaLuLiCaloriesFriendsRankPage> {

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
                        "好友排行榜",
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

  static Stack singleSportButton(Image sportIcon,) {
    return Stack(children: [
      ClipOval(child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: 30,
            height: 30,
            color: Color(0xffffffff),
          ),
          Container(
            width: 20,
            height: 20,
            color: Colors.transparent,
            child: sportIcon,
          ),
        ],
      ),),
      ClipOval(child: Container(
        width: 30,
        height: 30,
        child: FlatButton(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: (){},
          child: null,
        ),
      ),),
    ],);
  }

  static Container singleFriendCard(
    Size size,
    Image friendAvatar,
    String friendName,
    int cal,
  ) {
    return Container(
      width: size.width,
      height: 85,
      color: Color(0xFFFFFFFF),
      child: Container(
        color: Color(0xA5FFA200),
        child: Row(children: [
          Container(width: 10,), // 空白填充
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(65.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 1.0), // 阴影xy轴偏移量
                    blurRadius: 5.0, // 阴影模糊程度
                    spreadRadius: 2.0 // 阴影扩散程度
                ),
              ],
            ),
            child: ClipOval(child: friendAvatar, ),
          ),
          Container(width: 15,), // 空白填充
          Expanded(child: Container(
            child: Column(
              children: [
                Container(height: 15,), // 空白填充
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      friendName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    Expanded(child: Container(),),
                  ],
                ),
                Container(height: 5,), // 空白填充
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Container(),),
                    singleSportButton(
                      Image.asset('assets/images/mainPage/sportCard/basketball.png'),
                    ),
                    Container(width: 5,), // 空白填充
                    singleSportButton(
                      Image.asset('assets/images/mainPage/sportCard/swimming.png'),
                    ),
                    Container(width: 5,), // 空白填充
                    singleSportButton(
                      Image.asset('assets/images/mainPage/sportCard/mountain.png'),
                    ),
                    Container(width: 5,), // 空白填充
                    singleSportButton(
                      Image.asset('assets/images/mainPage/sportCard/running.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),),
          Container(width: 5,), // 空白填充
          Container(
            width: 120,
            child: Column(children: [
            Expanded(child: Container(),),
            Row(children: [
              Expanded(child: Container(),),
              Container(child: Text(
                '已消耗',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Hiragino Sans GB",
                  fontSize: 16,
                  color: Color(0xff000000),
                ),
              ),),
            ],),
            Container(height: 1,), // 空白填充
            Row(children: [
              Expanded(child: Container(),),
              Text(
                cal.toString() + ' Cal',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Hiragino Sans GB",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
            ],),
            Expanded(child: Container(),),
          ],),),
          Container(width: 10,), // 空白填充
        ],),
      ),
    );
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              Expanded(child: Container(child: ListView(children: [
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar1.png'),
                  '小卡',
                  10000,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar2.png'),
                  '是多多呀',
                  273,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar3.png'),
                  '热心市民灰灰',
                  206,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar4.png'),
                  'Gretal',
                  138,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar5.png'),
                  'John Kim',
                  73,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar1.png'),
                  '小卡',
                  72,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar2.png'),
                  '是多多呀',
                  71,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar3.png'),
                  '热心市民灰灰',
                  70,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar4.png'),
                  'Gretal',
                  42,
                ),
                Container(height: 15,), // 空白填充
                singleFriendCard(
                  size,
                  Image.asset('assets/images/FriendsRankPage/testAvatar5.png'),
                  'John Kim',
                  41,
                ),
              ],),),),
              // 测试数据
            ],),
            Column(children: [
              Expanded(child: Container(),),
              Stack(children: [
                Container(
                  height: 90,
                  color: Color(0xE5979797),
                  child:Stack(children: [
                    Row(children: [
                      Expanded(child: Container(),), // 空白填充
                      Text(
                        '管理好友名单',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Hiragino Sans GB",
                          fontSize: 24,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      Expanded(child: Container(),), // 空白填充
                    ],),
                    Row(children: [
                      Container(width: 50,), // 空白填充
                      Container(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.expand_less,
                          color: Color(0xffFFFFFF),
                          size: 30,
                        ),
                      ),
                      Expanded(child: Container(),), // 空白填充
                    ],),
                  ],),
                ),
                Container(
                  width: size.width,
                  height: 90,
                  child: FlatButton(
                    child: null,
                    color: Colors.transparent,
                    onPressed: (){
                      Navigator.popAndPushNamed(context, "/main/FriendsManage");
                    },
                  ),
                ),
              ],),
            ],),
          ],),
        ),
      ),
    );
  }
}