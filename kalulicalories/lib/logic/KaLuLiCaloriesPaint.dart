import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class WeightChartLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double maxChartTop = 10;
    double maxChartDown = NumUtil.subtract(size.width, 10);
    double midChartX = NumUtil.divide(size.width, 2);
    double midChartY = 100;
    LinearGradient weightLineColor = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xff01579B), Color(0xff81D4FA)],
    );
    Paint _paint = Paint()
      ..shader = weightLineColor.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height)
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    var _path = Path();
    _path.moveTo(0, 0);
    _path.lineTo(100, 100);
    canvas.drawPath(_path, _paint);
    _path.lineTo(NumUtil.divide(size.width, 2), 100);
    canvas.drawPath(_path, _paint);
    _path.lineTo(size.width, 100);
    canvas.drawPath(_path, _paint);
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0x4226333F)
      ..strokeWidth = 3.0
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);
    _path = Path();
    _path.moveTo(0, NumUtil.add(0, 10),);
    _path.lineTo(100, NumUtil.add(100, 10),);
    canvas.drawPath(_path, _paint);
    _path.lineTo(NumUtil.divide(size.width, 2), NumUtil.add(100, 10),);
    canvas.drawPath(_path, _paint);
    _path.lineTo(size.width, NumUtil.add(100, 10),);
    canvas.drawPath(_path, _paint);

    Offset offsetRing = Offset(midChartX, midChartY);
    Paint ringPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0x32324148)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawCircle(offsetRing, 15, ringPaint);
    ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xBF3391FF)
      ..strokeWidth = 3;
    canvas.drawCircle(offsetRing, 12, ringPaint);
    ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xffA0D4FA)
      ..strokeWidth = 3;
    canvas.drawCircle(offsetRing, 5, ringPaint);
    ringPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xffFFFFFF);
    canvas.drawCircle(offsetRing, 4, ringPaint);
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


class KaLuLiCaloriesPaint extends StatefulWidget {
  KaLuLiCaloriesPaint ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesPaintState createState() =>  _KaLuLiCaloriesPaintState();
}

class _KaLuLiCaloriesPaintState extends State<KaLuLiCaloriesPaint> {
  static Divider overWeightDivider() {
    return Divider(
      height: 2.5,
      thickness: 2.5,
      color: Color(0xffFF7043),
    );
  }

  static Divider targetWeightDivider() {
    return Divider(
      height: 2.5,
      thickness: 2.5,
      color: Color(0xff00E8C6),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 155,
      child: Stack(children: [
        Column(children: [
          Container(height: 20,), // 空白填充
          overWeightDivider(),
          Expanded(child: Container(),), // 空白填充
          targetWeightDivider(),
          Container(height: 20,), // 空白填充
        ],),
        CustomPaint(
          size: Size(double.infinity, 155),
          painter: WeightChartLinePainter(),
        ),
      ],),
    );
  }
}