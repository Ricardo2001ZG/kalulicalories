import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class KaLuLiCaloriesBMICalc {
  double _bmi(int height, double weight) {
    double heightM = NumUtil.divide(height, 100);
    double heightPower = NumUtil.multiply(heightM, heightM);
    double bmi = NumUtil.divide(weight, heightPower);
    bmi = NumUtil.getNumByValueDouble(bmi, 1);
    return bmi;
  }

  Map _boyBMIMap() {
    Map boyBMI = Map();
    List weightData = [];
    weightData = [18.5, 23.9, 27.9];
    boyBMI["18"] = weightData;
    weightData = [18.4, 23.8, 27.8];
    boyBMI["17"] = weightData;
    weightData = [18.1, 23.5, 27.4];
    boyBMI["16"] = weightData;
    weightData = [17.7, 23.1, 26.9];
    boyBMI["15"] = weightData;
    weightData = [17.2, 22.6, 26.4];
    boyBMI["14"] = weightData;
    weightData = [16.5, 21.9, 25.7];
    boyBMI["13"] = weightData;
    weightData = [15.6, 21.0, 24.7];
    boyBMI["12"] = weightData;
    weightData = [14.9, 20.3, 23.6];
    boyBMI["11"] = weightData;
    weightData = [14.2, 19.6, 22.5];
    boyBMI["10"] = weightData;
    weightData = [13.5, 18.9, 21.4];
    boyBMI["9"] = weightData;
    weightData = [12.7, 18.1, 20.3];
    boyBMI["8"] = weightData;
    weightData = [12, 17.4, 19.2];
    boyBMI["7"] = weightData;
    return boyBMI;
  }

  Map _girlBMIMap() {
    Map girlBMI = Map();
    List weightData = [];
    weightData = [18.5, 23.9, 27.9];
    girlBMI["18"] = weightData;
    weightData = [18.4, 23.8, 27.7];
    girlBMI["17"] = weightData;
    weightData = [18.3, 23.7, 27.4];
    girlBMI["16"] = weightData;
    weightData = [18, 23.4, 26.9];
    girlBMI["15"] = weightData;
    weightData = [17.6, 23.0, 26.9];
    girlBMI["14"] = weightData;
    weightData = [17.2, 22.6, 25.6];
    girlBMI["13"] = weightData;
    weightData = [16.5, 21.9, 24.5];
    girlBMI["12"] = weightData;
    weightData = [15.7, 21.1, 23.3];
    girlBMI["11"] = weightData;
    weightData = [14.6, 20.0, 21.1];
    girlBMI["10"] = weightData;
    weightData = [13.6, 19.0, 21.0];
    girlBMI["9"] = weightData;
    weightData = [12.7, 18.1, 19.9];
    girlBMI["8"] = weightData;
    weightData = [11.8, 17.2, 18.9];
    girlBMI["7"] = weightData;
    return girlBMI;
  }

  int _weightState(double bmi, int age, int sex) {
    if (age >= 18) {
      List weightData = [18.5, 23.9, 27.9];
      if (bmi <= weightData[0]) {
        return 1;
      } else if (bmi <= weightData[1]) {
        return 2;
      } else if (bmi <= weightData[2]) {
        return 3;
      } else if (bmi > weightData[2]) {
        return 4;
      }
    } else if (age < 7) {
      return 5;
    }
    Map bmiMap = Map();
    if (sex == 1) {
      bmiMap = _boyBMIMap();
    }else {
      bmiMap = _girlBMIMap();
    }
    String ageStr = age.toString();
    if (bmi <= bmiMap[ageStr][0]) {
      return 1;
    } else if (bmi <= bmiMap[ageStr][1]) {
      return 2;
    } else if (bmi <= bmiMap[ageStr][2]) {
      return 3;
    } else if (bmi > bmiMap[ageStr][2]) {
      return 4;
    }
    return 5;
  }

  static Text _dialogTitle(String titleText,){
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

  static Text _dialogButtonText(String buttonText,){
    return Text(
      buttonText,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 12.0,
        color: Color(0xffFFA200),
      ),
    );
  }

  static void _wrongDialog(
      BuildContext context,
      String dialogTitle,
      String dialogText,
      )
  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: _dialogTitle(dialogTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    dialogText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Hiragino Sans GB",
                      fontSize: 16.0,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
            // 下方按钮
            actions: <Widget>[
              FlatButton(
                child: _dialogButtonText("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static Text _bmiStateDialogText(String dialogText) {
    return Text(
      dialogText,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 14.0,
        color: Color(0xff000000),
      ),
    );
  }

  static void _bmiStateDialog(
      BuildContext context,
      String dialogTitle,
      double bmi,
      String targetBMIState,
      double targetBMI,
      )
  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: _dialogTitle("您的体重：" + dialogTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _bmiStateDialogText("您的 BMI 指数为：" + bmi.toString()),
                  _bmiStateDialogText("您的目标体重：" + targetBMIState),
                  _bmiStateDialogText("您的目标 BMI 指数为：" + targetBMI.toString()),
                ],
              ),
            ),
            // 下方按钮
            actions: <Widget>[
              FlatButton(
                child: _dialogButtonText("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  static String _bmiStateTitleText(int weightState) {
    if (weightState == 4) {
      return "肥胖";
    } else if (weightState == 3) {
      return "超重";
    } else if (weightState == 2) {
      return "正常";
    }
    return "过轻";
  }

  void calcInput(
      int height,
      double weight,
      double targetWeight,
      int age,
      int sex,
      BuildContext context,
    ) {
    if (age < 7) {
      _wrongDialog(context, "数据有误", "请输入年龄大于7的正确参数。");
    } else {
      double bmi = _bmi(height, weight);
      double targetBMI = _bmi(height, targetWeight);
      int weightState = _weightState(bmi, age, sex);
      int targetWeightState = _weightState(targetBMI, age, sex);
      if (weightState == 5) {
        _wrongDialog(context, "数据有误", "请输入年龄大于7的正确参数。");
      }
      _bmiStateDialog(
        context,
        _bmiStateTitleText(weightState),
        bmi,
        _bmiStateTitleText(targetWeightState),
        targetBMI,
      );
    }
  }
}