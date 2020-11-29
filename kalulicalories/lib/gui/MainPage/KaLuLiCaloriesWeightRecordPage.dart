
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesPaint.dart';

class KaLuLiCaloriesWeightRecordPage extends StatefulWidget {
  KaLuLiCaloriesWeightRecordPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesWeightRecordPageState createState() =>  _KaLuLiCaloriesWeightRecordPageState();
}

class _KaLuLiCaloriesWeightRecordPageState extends State<KaLuLiCaloriesWeightRecordPage> {

  static double weightTarget = 59.1;
  static String weightDataDate = 'October 22, 2020';
  static int weightChartCardButtonState = 1;
  static double weightChartCardNumber = 60.1;

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
                          color: Color(0x5172909D),
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
                        "体重记录",
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontFamily: "Hiragino Sans GB", fontSize: 28,),
                      ),
                    ],),
                  ],),
                ),
                Expanded(child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),), // 空白填充
                Container(
                  width: 50,
                  height: double.infinity,
                  child: Column(children: [
                    Expanded(child:
                    Container(width:50, height: double.infinity,),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Stack(children: [
                        Container(
                          width: 50,
                          height: 50,
                          color: Color(0xDDFFA200),
                          child: Icon(
                            Icons.add,
                            color: Color(0xffffffff),
                            size: 32,
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors.transparent,
                          child: FlatButton(
                            child: null,
                            onPressed: (){},
                          ),
                        ),
                      ],),
                    ),
                    Expanded(child:
                      Container(width:50, height: double.infinity,),
                    ),
                  ],),
                ),
              ],),
            ),),
            Container(width: 20, height: double.infinity,), // 空白填充
          ],),
        ),
        Container(width: double.infinity, height: 10,), // 空白填充
      ],),
    );
  }

  static Container singleWeightChartCardButton(String buttonText, int whichButton){
    FontWeight buttonFontWeight = FontWeight.w500;
    if(whichButton == weightChartCardButtonState) {
      buttonFontWeight = FontWeight.bold;
    }
    return Container(
      width: 55,
      height: 30,
      child: Stack(children: [
        Column(children: [
          Expanded(child: Container(),), // 空白填充
          Row(children: [
            Expanded(child: Container(),), // 空白填充
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Helvetica",
                fontSize: 14,
                color: Color(0xff000000),
                fontWeight: buttonFontWeight,
              ),
            ),
            Expanded(child: Container(),), // 空白填充
          ],),
          Expanded(child: Container(),), // 空白填充
        ],),
        FlatButton(
          child: null,
          color: Colors.transparent,
          onPressed: (){
            weightChartCardButtonState = whichButton;
            _refreshWeightChartCardButtonBar.reload();
          },
        ),
      ],),
    );
  }

  static Row weightChartCardButtonBar(){
    return Row(children: [
      singleWeightChartCardButton('month', 1),
      singleWeightChartCardButton('year', 2),
      singleWeightChartCardButton('all', 3),
    ],);
  }

  static var _refreshWeightChartCardButtonBar = RefreshableView(
    builder: (BuildContext context) {
      return weightChartCardButtonBar();
    }
  );

  static Row weightChartCardDateBar(String weightDataDateString,) {
    return Row(children: [
      Container(width: 30,), // 空白填充
      Text(
        weightDataDateString,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Hiragino Sans GB",
          fontSize: 14,
          color: Color(0xff000000),
        ),
      ),
      Expanded(child: Container(),), // 空白填充
    ],);
  }

  static var _refreshWeightChartCardDateBar = RefreshableView(
      builder: (BuildContext context) {
        return weightChartCardDateBar(weightDataDate,);
      }
  );

  static var _refreshWeightChartCardNumberText = RefreshableView(
      builder: (BuildContext context) {
        return Text(
          weightChartCardNumber.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: "Hiragino Sans GB",
            fontSize: 18,
            color: Color(0xff000000),
          ),
        );
      }
  );

  static Container singleWeightChartCardContainer(String containerText,){
    return Container(
      width: 65,
      height: 230,
      child: Column(children: [
        Container(height: 35,), // 空白填充
        Container(
          width: 65,
          height: 155,
          child: VerticalDivider(
            color: Color(0x80475962),
            width: 1,
            thickness: 1,
          ),
        ),
        Container(height: 5,), // 空白填充
        Container(
          width: 65,
          height: 20,
          child: Text(
            containerText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Helvetica",
              fontSize: 14,
              color: Color(0xff72909D),
            ),
          ),
        ),
        Container(height: 15,), // 空白填充
      ],),
    );
  }



  static Container weightChartCard() {
    return Container(
      width: double.infinity,
      height: 290,
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 30,
          child: Row(children: [
            Container(width: 30,), // 空白填充
            Text(
              '数据',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Hiragino Sans GB",
                fontSize: 18,
                color: Color(0xff000000),
              ),
            ),
            Expanded(child: Container(),), // 空白填充
            _refreshWeightChartCardButtonBar,
            Container(width: 30,), // 空白填充
          ],),
        ),
        Container(
          width: double.infinity,
          height: 30,
          child: _refreshWeightChartCardDateBar,
        ),
        Container(
          width: double.infinity,
          height: 230,
          child: Stack(children: [
            Row(children: [
              Expanded(child: Container(),), // 空白填充
              Stack(children: [
                Container(
                  width: 65,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80324148),
                        offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                        blurRadius: 23.0, //阴影模糊程度
                        spreadRadius: 5.0 //阴影扩散程度
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 65,
                  height: 230,
                  color: Colors.transparent,
                  child: Stack(children: [
                    Column(children: [
                      Container(height: 15,), // 空白填充
                      Container(
                        width: double.infinity,
                        height: 25,
                        child: Row(children: [
                          Expanded(child: Container(),), // 空白填充
                          _refreshWeightChartCardNumberText,
                          Expanded(child: Container(),), // 空白填充
                        ],),
                      ),
                      Expanded(child: Container(),), // 空白填充
                    ],),
                    Column(children: [
                      Container(height: 30,), // 空白填充
                      Container(
                        width: double.infinity,
                        height: 25,
                        child: Row(children: [
                          Expanded(child: Container(),), // 空白填充
                          Text(
                            'kg',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Hiragino Sans GB",
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                          Container(width: 15,), // 空白填充
                        ],),
                      ),
                      Expanded(child: Container(),), // 空白填充
                    ],),
                  ],),
                ),
              ],),
              Expanded(child: Container(),), // 空白填充
            ],),
            Column(children: [
              Container(height: 35,),
              Container(
                height: 155,
                child: KaLuLiCaloriesPaint(),
              ),
              Container(height: 40,)
            ],),
            ListView(
              scrollDirection: Axis.horizontal,
              children: [
                singleWeightChartCardContainer('Jan'),
                singleWeightChartCardContainer('Feb'),
                singleWeightChartCardContainer('Mar'),
                singleWeightChartCardContainer('Apr'),
                singleWeightChartCardContainer('May'),
                singleWeightChartCardContainer('Jun'),
                singleWeightChartCardContainer('Jul'),
                singleWeightChartCardContainer('Aug'),
                singleWeightChartCardContainer('Sept'),
                singleWeightChartCardContainer('Oct'),
                singleWeightChartCardContainer('Nov'),
                singleWeightChartCardContainer('Dec'),
              ],
            ),
          ],),
        ), // chart
      ],),
    );
  }


  static Row singleLegendCardPart(Color lineColor, String lineText) {
    return Row(children: [
      Container(
        width: 10,
        height: 2,
        child: Divider(
          thickness: 2,
          color: lineColor,
        ),
      ),
      Container(width: 20,), // 空白填充
      Text(
        lineText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Hiragino Sans GB",
          fontSize: 14,
          color: Color(0xff72909D),
        ),
      ),
    ],);
  }

  static Container legendCard() {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0x1972909D),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(children: [
        Expanded(flex:1, child: Container(),), // 空白填充
        Column(children: [
          Container(height: 10,), // 空白填充
          singleLegendCardPart(Color(0xffA0D4FA), '你的体重'),
          Container(height: 5,), // 空白填充
          singleLegendCardPart(Color(0xffFBC02D), '体重过轻'),
          Container(height: 10,), // 空白填充
        ],),
        Container(width: 50,), // 空白填充
        Column(children: [
          Container(height: 10,), // 空白填充
          singleLegendCardPart(Color(0xff00E8C6), '期望体重'),
          Container(height: 5,), // 空白填充
          singleLegendCardPart(Color(0xffFF7043), '已经超重'),
          Container(height: 10,), // 空白填充
        ],),
        Expanded(flex:2, child: Container(),), // 空白填充
      ],),
    );
  }

  static Stack singleWeightCard(
      Image backgroundImage,
      Color backgroundColor,
      String titleText,
      Color titleTextColor,
      String numberText,
      Color numberTextColor,
      String smallText,
      Color smallTextColor,
      ) {
    return Stack(children: [
      Container(
        width: 140,
        height: 175,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                blurRadius: 5.0, //阴影模糊程度
                spreadRadius: 2.0 //阴影扩散程度
            ),
          ],
        ),
        child: backgroundImage,
      ),
      Container(
        width: 140,
        height: 175,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(children: [
          Container(height: 15,), // 空白填充
          Row(children: [
            Container(width: 15,), // 空白填充
            Text(
              titleText,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Hiragino Sans GB",
                fontSize: 12,
                color: titleTextColor,
              ),
            ),
            Expanded(child: Container(),), // 空白填充
          ],),
          Container(height: 35,), // 空白填充
          Row(children: [
            Expanded(child: Container(),), // 空白填充
            Text(
              numberText,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Hiragino Sans GB",
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: numberTextColor,
              ),
            ),
            Expanded(child: Container(),), // 空白填充
          ],),
        ],),
      ),
      Container(
        width: 140,
        height: 175,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(children: [
          Container(height: 105,), // 空白填充
          Row(children: [
            Expanded(child: Container(),), // 空白填充
            Text(
              smallText,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "Hiragino Sans GB",
                fontSize: 12,
                color: smallTextColor,
              ),
            ),
            Expanded(child: Container(),), // 空白填充
          ],),
          Expanded(child: Container(),), // 空白填充
        ],),
      ),
    ],);
  }

  static Container singleWeightDataCard(int millisecondsSinceEpoch,double weightData) {
    // millisecond 时间戳
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String weekday = '';
    List weekdayList = [
      '', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    weekday = weekdayList[dateTime.weekday];
    weekdayList = null;
    String month = '';
    List monthList = [
      '', 'January', 'February', 'March',
      'April', 'May', 'June',
      'July', 'August', 'September',
      'October', 'November', 'December',
    ];
    month = monthList[dateTime.month];
    monthList = null;
    double weightDeviation = 0;
    Icon weightIcon = Icon(null);
    // Debug // 此处应当与上次体重数据进行对比，而不是目标体重
    weightData = NumUtil.getNumByValueDouble(weightData, 1);
    if(weightData > weightTarget) {
      weightIcon = Icon(Icons.call_made, color: Color(0xffFF7043),);
      weightDeviation = NumUtil.subtract(weightData, weightTarget);
    }else if(weightData <= weightTarget) {
      weightIcon = Icon(Icons.call_received, color: Color(0xff00E8C6),);
      weightDeviation = NumUtil.subtract(weightTarget, weightData);
    }
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(children: [
        // Container(width: 30,), // 空白填充
        Expanded(child: Container(),), // 空白填充
        Container(
          width: 300,
          height: 50,
          child: Row(children: [
            Container(
              width: 90,
              height: 50,
              child: Column(children: [
                Expanded(child: Container(),), // 空白填充
                Row(children: [
                  Text(
                    weekday,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                  Expanded(child: Container(),), // 空白填充
                ],),
                Container(height: 5,), // 空白填充
                Row(children: [
                  Text(
                    month + ' ' + dateTime.day.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                  Expanded(child: Container(),), // 空白填充
                ],),
                Expanded(child: Container(),), // 空白填充
              ],),
            ),
            Expanded(flex:2, child: Container(),), // 空白填充
            Container(
              width: 50,
              height: 50,
              child: Column(children: [
                Expanded(child: Container(),), // 空白填充
                Row(children: [
                  Expanded(child: Container(),), // 空白填充
                  Text(
                    weightData.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                ],),
                Container(height: 5,), // 空白填充
                Row(children: [
                  Expanded(child: Container(),), // 空白填充
                  Text(
                    'kg',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 14,
                      color: Color(0xff72909D),
                    ),
                  ),
                ],),
                Expanded(child: Container(),), // 空白填充
              ],),
            ),
            Expanded(flex:1, child: Container(),), // 空白填充
            weightIcon,
            Container(width: 5,), // 空白填充
            Container(
              width: 45,
              child: Column(children: [
                Expanded(child: Container(),), // 空白填充
                Row(children: [
                  Expanded(child: Container(),), // 空白填充
                  Text(
                    weightDeviation.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                  Expanded(child: Container(),), // 空白填充
                ],),
                Expanded(child: Container(),), // 空白填充
              ],),
            ),
          ],),
        ),
        Expanded(child: Container(),), // 空白填充
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
          child: Column(children: [
            appBarReturn(context, size),
            Expanded(child: Container(
              width: size.width,
              child: ListView(children: [
                weightChartCard(),
                Container(height: 10,), // 空白填充
                Row(children: [
                  Expanded(child: Container(),), // 空白填充
                  Container(width: 300,child: Column(children: [
                    legendCard(),
                    Container(height: 25,), // 空白填充
                    Container(
                      width: 300,
                      height: 175,
                      child: Row(children: [
                        singleWeightCard(
                          Image.asset(
                            'assets/images/WeightRecordPage/weightCardBackground1.png',
                            fit: BoxFit.fill,
                          ),
                          Color(0xffFFFFFF),
                          '目标', Color(0xff283641),
                          weightTarget.toString(), Color(0xff283641),
                          'kg', Color(0xff72909D),
                        ),
                        Container(width: 20,), // 空白填充
                        singleWeightCard(
                          Image.asset(
                            'assets/images/WeightRecordPage/weightCardBackground2.png',
                            fit: BoxFit.fill,
                          ),
                          Color(0xffFFA200),
                          '即时体重', Color(0xffFFFFFF),
                          '60.3', Color(0xffFFFFFF),
                          '- 1.4 kg 相差', Color(0xffFFFFFF),
                        ),
                      ],),
                    ),
                  ],),),
                  Expanded(child: Container(),), // 空白填充
                ],),
                Container(height: 20,), // 空白填充
                singleWeightDataCard(DateTime.now().millisecondsSinceEpoch, 60.2),
                singleWeightDataCard(DateTime.now().millisecondsSinceEpoch, 58.2),
                singleWeightDataCard(DateTime.now().millisecondsSinceEpoch, 60.1),
                singleWeightDataCard(DateTime.now().millisecondsSinceEpoch, 57.2111),
              ],),
            ),),
          ],),//
        ),
      ),
    );
  }
}