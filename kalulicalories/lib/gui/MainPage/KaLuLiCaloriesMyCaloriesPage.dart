
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';

class KaLuLiCaloriesMyCaloriesPage extends StatefulWidget {
  KaLuLiCaloriesMyCaloriesPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesMyCaloriesPageState createState() =>  _KaLuLiCaloriesMyCaloriesPageState();
}

class _KaLuLiCaloriesMyCaloriesPageState extends State<KaLuLiCaloriesMyCaloriesPage> {

  static Container appBarReturn(BuildContext context, Size size){
    double appBarReturnWidth = 0;
    if(size.width >= 400) {
      appBarReturnWidth = size.width;
    }else if (size.width <= 400) {
      appBarReturnWidth = 360;
    }
    return Container(
      width: appBarReturnWidth,
      height: 80,
      child: Column(children: [
        Container(width: double.infinity, height: 40,), // 空白填充
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

  static Container singleFoodCard(Image foodImage, String foodName, int cal, ) {
    return Container(
      width: 140,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(children: [
        Container(
          width: 140,
          height: 140,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: foodImage,
        ),
        Row(children: [
          Text(
            "10月15日",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 12,
              color: Color(0x99383838),
            ),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),

        // Container(height: 5,), // 空白填充
        Row(children: [
          Text(
            foodName,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 14,
              color: Color(0xff000000),
            ),
          ),
          Expanded(child: Container(),),
          Text(
            cal.toString() + ' Cal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Helvetica",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffFFA200),
            ),
          ),
        ],),
      ],),
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
            // background
            Column(children: [
              Stack(children: [
                // 填补图片与背景的白线间隙
                Container(height: 260,color: Color(0xffFFA200),),
                Column(children: [
                  Container(
                    height: 250,
                    color: Color(0xffFFA200),
                  ),
                  Container(
                    height: 120,
                    color: Color(0xffFFA200),
                    // alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/MyCaloriesPage/footer.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],),
              ],),
              Expanded(child: Container(
                child: Row(children: [
                  Expanded(flex: 2,child: Container(color: Color(0x1972909D),),),
                  Expanded(flex: 1,child: Container(color: Color(0xffffffff),),),
                ],),
              ),),
            ],),
            // main
            Column(children: [
              appBarReturn(context, size),
              Expanded(child: Row(children: [
                Expanded(child: Container(),), // 空白填充
                Container(
                  width: 300,
                  child: ListView(children: [
                    Container(height: 80,child: Row(children: [
                      Expanded(child: Container(),), // 空白填充
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(80.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 1.0), // 阴影xy轴偏移量
                                blurRadius: 5.0, // 阴影模糊程度
                                spreadRadius: 2.0 // 阴影扩散程度
                            ),
                          ],
                        ),
                        child: ClipOval(child:
                        Image.asset('assets/images/MyCaloriesPage/avatarGirl5.png'),
                        ),
                      ),
                      Expanded(child: Container(),), // 空白填充
                    ],),),
                    Container(height: 5,), // 空白填充
                    Container(child: Text(
                      "小卡",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 18,
                        color: Color(0xffF8F8F8),
                      ),
                    ),),
                    Container(height: 5,), // 空白填充
                    Container(
                      height: 60,
                      child: Row(children: [
                        Expanded(child: Container(),), // 空白填充
                        Stack(children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 1.0), // 阴影xy轴偏移量
                                    blurRadius: 10.0, // 阴影模糊程度
                                    spreadRadius: 2.0 // 阴影扩散程度
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            child: Row(children: [
                              Expanded(child: Container(),), // 空白填充
                              VerticalDivider(
                                color: Color(0xffECECEC),
                                width: 1, thickness: 1,
                              ),
                              Expanded(child: Container(),), // 空白填充
                            ],),
                          ),
                          Container(
                            width: 300,
                            child: Row(children: [
                              Expanded(flex: 1, child: Container(
                                child: Column(children: [
                                  Container(height: 5,), // 空白填充
                                  Text(
                                    "今日已摄入",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Hiragino Sans GB",
                                      fontSize: 14,
                                      color: Color(0x99383838),
                                    ),
                                  ),
                                  Container(height: 10,), // 空白填充
                                  Text(
                                    "10000 Cal",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Helvetica",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff383838),
                                    ),
                                  ),
                                  Container(height: 5,), // 空白填充
                                ],),
                              ),),
                              Expanded(flex: 1, child: Container(
                                child: Column(children: [
                                  Container(height: 5,), // 空白填充
                                  Text(
                                    "还可以摄入",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Hiragino Sans GB",
                                      fontSize: 14,
                                      color: Color(0x99383838),
                                    ),
                                  ),
                                  Container(height: 10,), // 空白填充
                                  Text(
                                    "10000 Cal",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Helvetica",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff383838),
                                    ),
                                  ),
                                  Container(height: 5,), // 空白填充
                                ],),
                              ),),
                            ],),
                          ),
                        ],),
                        Expanded(child: Container(),), // 空白填充
                      ],),
                    ),
                    Container(height: 10,), // 空白填充

                    Container(
                      width: 300,
                      height: 30,
                      child: Row(children: [
                        Expanded(child: Container(child: ListView.separated(
                          reverse: true,
                          scrollDirection:Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return singleSportButton(Image.asset('assets/images/mainPage/sportCard/running.png',),);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(width: 5,);
                          },
                        ),),),
                        Container(width: 10,), // 空白填充
                        Text(
                          '已消耗',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Hiragino Sans GB",
                            fontSize: 14,
                            color: Color(0xffffffff),
                          ),
                        ),
                        Container(width: 10,), // 空白填充
                        Text(
                          '300 Cal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Hiragino Sans GB",
                            fontSize: 14,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],),
                    ),
                    Container(height: 65,), // 空白填充
                    Container(child: Row(children: [
                      Text(
                        "记录",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Hiragino Sans GB",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],),),
                    Container(height: 20,), // 空白填充

                    Row(children: [
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/breakfast.png'),
                        "早餐",
                        1000, ),
                      Container(width: 20,),
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/lunch.png'),
                        "午餐",
                        1100, ),
                    ],),
                    Container(height: 20,), // 空白填充
                    Row(children: [
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/dinner.png'),
                        "晚餐",
                        1200, ),
                      Container(width: 20,),
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/snack.png'),
                        "加餐",
                        1300, ),
                    ],),
                    Container(height: 20,), // 空白填充
                    Row(children: [
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/breakfast.png'),
                        "早餐",
                        1000, ),
                      Container(width: 20,),
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/lunch.png'),
                        "午餐",
                        1100, ),
                    ],),
                    Container(height: 20,), // 空白填充
                    Row(children: [
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/dinner.png'),
                        "晚餐",
                        1200, ),
                      Container(width: 20,),
                      singleFoodCard(
                        Image.asset('assets/images/MyCaloriesPage/snack.png'),
                        "加餐",
                        1300, ),
                    ],),
                    Container(height: 20,), // 空白填充


                  ],),
                ),
                Expanded(child: Container(),), // 空白填充
              ],)),

            ],),
          ],),
        ),
      ),
    );
  }
}