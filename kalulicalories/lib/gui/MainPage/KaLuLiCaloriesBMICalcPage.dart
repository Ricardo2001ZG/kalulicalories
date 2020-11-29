
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';
import 'package:kalulicalories/logic/KaLuLiCaloriesBMICalc.dart';

class KaLuLiCaloriesBMICalcPage extends StatefulWidget {
  KaLuLiCaloriesBMICalcPage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesBMICalcPageState createState() =>  _KaLuLiCaloriesBMICalcPageState();
}

class _KaLuLiCaloriesBMICalcPageState extends State<KaLuLiCaloriesBMICalcPage> {

  static int sexCardState = 1;
  static int dataFieldState = 0;
  static TextEditingController _heightController = TextEditingController();
  static TextEditingController _weightController = TextEditingController();
  static TextEditingController _targetController = TextEditingController();
  static TextEditingController _ageController = TextEditingController();
  static FocusNode _textFieldFocusNode = FocusNode();

  void initState() {
    _heightController.text = "170";
    _weightController.text = "50.0";
    _targetController.text = "50.0";
    _ageController.text = "20";
    dataFieldState = 0;
    sexCardState = 1;
    super.initState();
  }

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
                              // 安全起见，此处释放焦点，否则激活键盘状态下返回 mainPage ，
                              // 会导致 mainPage 溢出。
                              _textFieldFocusNode.unfocus();
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
                        "BMI 计算器",
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
                            Icons.replay,
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
                            onPressed: (){
                              _heightController.text = "170";
                              _weightController.text = "50.0";
                              _targetController.text = "50.0";
                              _ageController.text = "20";
                              dataFieldState = 0;
                              sexCardState = 1;
                              _refreshDataFieldBar.reload();
                              _refreshSexCard.reload();
                            },
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

  static Stack singleSexCard(Image cardIcon, String cardText, bool ifOn) {
    BoxDecoration cardDecoration = BoxDecoration();
    Color cardTextColor = Color(0xffffffff);
    if (ifOn == true) {
      cardDecoration = BoxDecoration(
        color: Color(0xffFFA200),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0), //阴影xy轴偏移量
              blurRadius: 5.0, //阴影模糊程度
              spreadRadius: 2.0 //阴影扩散程度
          ),
        ],
      );
      cardTextColor = Color(0xffffffff);
    }else if (ifOn == false){
      cardDecoration = BoxDecoration(
        color: Color(0x19FFA200),
        borderRadius: BorderRadius.circular(8.0),
      );
      cardTextColor = Color(0xff72909D);
    }
    return Stack(children: [
      Container(
        width: 140,
        height: 140,
        decoration: cardDecoration,
        child: Column(children: [
          Container(height: 40,), // 空白填充
          Container(
            width: 36,
            height: 36,
            child: cardIcon,
          ), // icon
          Container(height: 20,), // 空白填充
          Container(
            child: Text(
              cardText,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontFamily: "Helvetica",
                fontSize: 18,
                color: cardTextColor,
              ),
            ),
          ),
        ],),
      ),
      Container(
        width: 140,
        height: 140,
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FlatButton(onPressed: (){
            if(ifOn == false){
              if(sexCardState == 1) {
                sexCardState = 2;
                _refreshSexCard.reload();
              }else if (sexCardState == 2) {
                sexCardState = 1;
                _refreshSexCard.reload();
              }
            }
          }, child: null,),
        ),
      ),
    ],);
  }

  static var _refreshSexCard = RefreshableView(
    builder: (BuildContext context) {
      Row sexCardRow = Row();
      if(sexCardState == 1){
        sexCardRow = Row(children: [
          singleSexCard(
            Image.asset("assets/images/BMICalcPage/maleIconOn.png"),
            "Male",
            true,
          ),
          Container(width: 20,), // 空白填充
          singleSexCard(
            Image.asset("assets/images/BMICalcPage/femaleIconOff.png"),
            "Female",
            false,
          ),
        ],);
      }else if(sexCardState == 2) {
        sexCardRow = Row(children: [
          singleSexCard(
            Image.asset("assets/images/BMICalcPage/maleIconOff.png"),
            "Male",
            false,
          ),
          Container(width: 20,), // 空白填充
          singleSexCard(
            Image.asset("assets/images/BMICalcPage/femaleIconOn.png"),
            "Female",
            true,
          ),
        ],);
      }
      return Container(
        width: 300,
        height: 140,
        child: sexCardRow,
      );
    }
  );

  static Container singleDataButton(int buttonType, BuildContext context) {
    Icon buttonIcon = Icon(null);
    if(buttonType == 1) {
      buttonIcon = Icon(Icons.arrow_drop_up_rounded, color: Color(0xff000000), size: 30,);
    }else if(buttonType == 2){
      buttonIcon = Icon(Icons.arrow_drop_down_rounded, color: Color(0xff000000), size: 30,);
    }
    return Container(
      width: 30,
      height: 30,
      color: Colors.transparent,
      child: Stack(children: [
        ClipOval(child: Container(color: Color(0xffffffff),),),
        buttonIcon,
        FlatButton(
          child: null,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: (){
            _textFieldFocusNode.unfocus();
            _refreshDataFieldBar.reload();
            if(buttonType == 1) {
              if(dataFieldState == 1){
                int heightData = int.parse(_heightController.text);
                heightData = heightData + 1;
                _heightController.text = heightData.toString();
              }else if(dataFieldState == 2){
                double weightData = double.parse(_weightController.text);
                weightData = NumUtil.add(weightData, 0.1);
                _weightController.text = weightData.toString();
              }else if(dataFieldState == 3){
                double targetWeight = double.parse(_targetController.text);
                targetWeight = NumUtil.add(targetWeight, 0.1);
                _targetController.text = targetWeight.toString();
              }else if(dataFieldState == 4){
                int ageData = int.parse(_ageController.text);
                ageData = ageData + 1;
                _ageController.text = ageData.toString();
              }
            }else if(buttonType == 2){
              if(dataFieldState == 1){
                int heightData = int.parse(_heightController.text);
                heightData = heightData - 1;
                _heightController.text = heightData.toString();
              }else if(dataFieldState == 2){
                double weightData = double.parse(_weightController.text);
                weightData = NumUtil.subtract(weightData, 0.1);
                _weightController.text = weightData.toString();
              }else if(dataFieldState == 3){
                double targetWeight = double.parse(_targetController.text);
                targetWeight = NumUtil.subtract(targetWeight, 0.1);
                _targetController.text = targetWeight.toString();
              }else if(dataFieldState == 4){
                int ageData = int.parse(_ageController.text);
                ageData = ageData - 1;
                _ageController.text = ageData.toString();
              }
            }
            _refreshDataFieldBar.reload();
          },
        ),
      ],),
    );
  }

  static Container singleDataField(
    TextEditingController _textController,
    String dataFieldText,
    int whichField, bool ifChoose,
    BuildContext context,
  )
  {
    String regexpRule = "[0-9]";
    String dataFieldTextFill = "";
    if(whichField == 1){
      dataFieldTextFill = _heightController.text;
    }else if(whichField == 2){
      dataFieldTextFill = _weightController.text;
      regexpRule = "[0-9.]";
    }else if(whichField == 3){
      dataFieldTextFill = _targetController.text;
      regexpRule = "[0-9.]";
    }else if(whichField == 4){
      dataFieldTextFill = _ageController.text;
      regexpRule = "[0-9]";
    }

    Row dataButtonBar = Row(children: [
      Container(width: 10,), // 空白填充
      ClipRRect( //剪裁为圆角矩形
        borderRadius: BorderRadius.circular(36.0),
        child: Container(
          width: 130,
          height: 70,
          color: Colors.transparent,
          child: FlatButton(
            child: Text(
              dataFieldTextFill,
              textAlign:TextAlign.center,
              style: TextStyle(
                color: Color(0xff72909D),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: (){
              _textFieldFocusNode.unfocus();
              dataFieldState = whichField;
              _refreshDataFieldBar.reload();
            },
          ),
        ),
      ),
      Container(width: 10,), // 空白填充
    ],);
    if(ifChoose == true){
      dataButtonBar = Row(children: [
        singleDataButton(2, context),
        Container(
          width: 90,
          height: 70,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: TextField(
            decoration: null,
            focusNode: _textFieldFocusNode,
            maxLength: 5,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            cursorColor: Color(0xffffffff),
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            controller: _textController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(regexpRule)),
            ],
          ),
        ),
        singleDataButton(1, context),
      ],);
    }

    return Container(
      width: 300,
      height: 70,
      child: Row(children: [
        Container(width: 50,), // 空白填充
        Container(child: Text(
          dataFieldText,
          textAlign: TextAlign.left,
          style: new TextStyle(fontFamily: "Hiragino Sans GB", fontSize: 14,),
        ),),
        Expanded(child: Container(),), // 空白填充
        Container(
          width: 150,
          height: 70,
          child: Stack(children: [
            Row(children: [
              Container(width: 10,), // 空白填充
              ClipRRect( //剪裁为圆角矩形
                borderRadius: BorderRadius.circular(36.0),
                child: Container(
                  width: 130,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xFFFFA200), Color(0xFFFFCB00), Color(0xFFFFA200)],
                  ),),
                ),
              ),
              Container(width: 10,), // 空白填充
            ],),
            dataButtonBar,
          ],),
        ),
      ],),
    );
  }

  static var _refreshDataFieldBar = RefreshableView(
    builder: (BuildContext context) {
      bool dataField1ifChoose = false;
      bool dataField2ifChoose = false;
      bool dataField3ifChoose = false;
      bool dataField4ifChoose = false;
      if(dataFieldState == 1){dataField1ifChoose = true;}
      else {dataField1ifChoose = false;}
      if(dataFieldState == 2){dataField2ifChoose = true;}
      else {dataField2ifChoose = false;}
      if(dataFieldState == 3){dataField3ifChoose = true;}
      else {dataField3ifChoose = false;}
      if(dataFieldState == 4){dataField4ifChoose = true;}
      else {dataField4ifChoose = false;}
      return Container(
        width: 300,
        height: 340,
        child: Column(children: [
          // Container(height: 40,), // 空白填充
          singleDataField(_heightController, "cm", 1, dataField1ifChoose, context),
          Container(height: 15,), // 空白填充
          singleDataField(_weightController, "kg", 2, dataField2ifChoose, context),
          Container(height: 15,), // 空白填充
          singleDataField(_targetController, "目标", 3, dataField3ifChoose, context),
          Container(height: 15,), // 空白填充
          singleDataField(_ageController, "年龄", 4, dataField4ifChoose, context),
          Container(height: 15,), // 空白填充
        ],),
      );
    }
  );

  static Container calcButton(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      child: Stack(children: [
        Container(
          width: 300,
          height: 55,
          child: Image.asset(
            "assets/images/BMICalcPage/button.png",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: 300,
          height: 55,
          child: FlatButton(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            onPressed: (){
              _textFieldFocusNode.unfocus();
              var calc = KaLuLiCaloriesBMICalc();
              int heightData = int.parse(_heightController.text);
              double weightData = double.parse(_weightController.text);
              double targetWeight = double.parse(_targetController.text);
              int ageData = int.parse(_ageController.text);
              calc.calcInput(
                heightData,
                weightData,
                targetWeight,
                ageData,
                sexCardState,
                context,
              );
            },
            child: null,
          ),
        ),
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
          child: ListView(children: [
            Column(children: [
              appBarReturn(context, size),
              Container(/*width: 300, height: 140, */child: _refreshSexCard,),
              Container(width: double.infinity, height: 40,), // 空白填充
              _refreshDataFieldBar,
              Container(width: double.infinity, height: 35,), // 空白填充
              calcButton(context),
            ],),
          ],),
        ),
      ),
    );
  }
}