
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kalulicalories/logic/RefreshableStatefulWidget.dart';

class KaLuLiCaloriesFriendsManagePage extends StatefulWidget {
  KaLuLiCaloriesFriendsManagePage ({Key key}) : super(key : key);
  @override
  _KaLuLiCaloriesFriendsManagePageState createState() =>  _KaLuLiCaloriesFriendsManagePageState();
}

class _KaLuLiCaloriesFriendsManagePageState extends State<KaLuLiCaloriesFriendsManagePage> {

  static int pageState = 1;
  static bool ifPage4Null = true;

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
                  Navigator.popAndPushNamed(context, "/main/FriendsRank");
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

  static Container singleButtonBarBackground(String buttonText,) {
    return Container(
      width: 88,
      child: Row(children: [
        Expanded(child: Container(),), // 空白填充
        Text(
          buttonText,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontFamily: "Hiragino Sans GB",
            fontSize: 15,
            color: Color(0xffffffff),
          ),
        ),
        Expanded(child: Container(),), // 空白填充
      ],),
    );
  }

  static Stack singleButtonBarButton(String buttonText, int whichButton) {
    if(whichButton != pageState){
      return Stack(children: [
        Container(
          width: 88,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FlatButton(
              child: null,
              color: Colors.transparent,
              onPressed: () {
                pageState = whichButton;
                _refreshFriendsManageButtonBar.reload();
                if(whichButton == 2){
                  // 判断申请列表是否为空，空表返回空表页面
                  ifPage4Null = false;
                }
                _refreshFriendsManagePage.reload();
              },
            ),
          ),
        ),
      ],);
    }
    return Stack(children: [
      Container(
        width: 88,
        height: 40,
        color: Color(0xffFFFFFF),
        child: Row(children: [
          Expanded(child: Container(),), // 空白填充
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 15,
              color: Color(0xffFFA200),
            ),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),
      ),
      Container(
        width: 88,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FlatButton(
            child: null,
            color: Colors.transparent,
            onPressed: () {},
          ),
        ),
      ),
    ],);
  }

  static Container friendsManageButtonBar() {
    return Container(
      width: 300,
      height: 40,
      child: Stack(children: [
        Row(children: [
          Expanded(child: Container(),), // 空白填充
          Container(
            width: 270,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xffffffff),
                width: 2,
              ),
            ),
            child: Row(children: [
              singleButtonBarBackground('我的好友'),
              VerticalDivider(width: 1, color: Color(0xffFFFFFF),),
              singleButtonBarBackground('好友请求'),
              VerticalDivider(width: 1, color: Color(0xffFFFFFF),),
              singleButtonBarBackground('新增好友'),
            ],),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),
        Row(children: [
          Expanded(child: Container(),), // 空白填充
          Container(
            width: 270,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xffffffff),
                width: 2,
              ),
            ),
            child: Row(children: [
              singleButtonBarButton('我的好友', 1),
              VerticalDivider(width: 1, color: Color(0xffFFFFFF),),
              singleButtonBarButton('好友请求', 2),
              VerticalDivider(width: 1, color: Color(0xffFFFFFF),),
              singleButtonBarButton('新增好友', 3),
            ],),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),
      ],),
    );
  }

  static var _refreshFriendsManageButtonBar = RefreshableView(
    builder: (BuildContext context)
    {return friendsManageButtonBar();}
  );

  static Container singleFriendManageCard(
    Image friendAvatar,
    String friendName,
  )
  {
    return Container(
      height: 100,
      child: Row(children: [
        Container(width: 40,), // 空白填充
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
                spreadRadius: 2.0, // 阴影扩散程度
              ),
            ],
          ),
          child: ClipOval(child: friendAvatar, ),
        ),
        Container(width: 20,), // 空白填充
        Container(child: Column(children: [
          Expanded(child: Container(),), // 空白填充
          Text(
            friendName,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 20,
              color: Color(0xffffffff),
            ),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),),
        Expanded(child: Container(),), // 空白填充
        Container(
          width: 70,
          child: Column(children: [
            Expanded(child: Container(),), // 空白填充
            Stack(children: [
              Row(children: [
                Expanded(child: Container(),), // 空白填充
                Container(
                  height: 30,
                  child: Column(children: [
                    Expanded(child: Container(),), // 空白填充
                    Text(
                      '解除好友',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Expanded(child: Container(),), // 空白填充
                  ],),
                ),
                Expanded(child: Container(),), // 空白填充
              ],),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xffffffff),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                    child: null,
                    color: Colors.transparent,
                    onPressed: () {},
                  ),
                ),
              ),
            ],),
            Expanded(child: Container(),), // 空白填充
          ],),
        ),
        Container(width: 40,), // 空白填充
      ],),
    );
  }

  static Container singleFriendManageRequestCard(
      Image friendAvatar,
      String friendName,
      )
  {
    return Container(
      height: 100,
      child: Row(children: [
        Container(width: 40,), // 空白填充
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
                spreadRadius: 2.0, // 阴影扩散程度
              ),
            ],
          ),
          child: ClipOval(child: friendAvatar, ),
        ),
        Container(width: 20,), // 空白填充
        Container(child: Column(children: [
          Expanded(child: Container(),), // 空白填充
          Text(
            friendName,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 20,
              color: Color(0xffffffff),
            ),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),),
        Expanded(child: Container(),), // 空白填充
        Container(
          width: 70,
          child: Column(children: [
            Expanded(child: Container(),), // 空白填充
            Stack(children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xffFFFFFF),
                    width: 2,
                  ),
                ),
              ),
              Row(children: [
                Expanded(child: Container(),), // 空白填充
                Container(
                  height: 30,
                  child: Column(children: [
                    Expanded(child: Container(),), // 空白填充
                    Text(
                      '同意',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 15,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    Expanded(child: Container(),), // 空白填充
                  ],),
                ),
                Expanded(child: Container(),), // 空白填充
              ],),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                    child: null,
                    color: Colors.transparent,
                    onPressed: () {},
                  ),
                ),
              ),
            ],),
            Container(height: 5,), // 空白填充
            Stack(children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFFFFFFF),
                    width: 2,
                  ),
                ),
              ),
              Row(children: [
                Expanded(child: Container(),), // 空白填充
                Container(
                  height: 30,
                  child: Column(children: [
                    Expanded(child: Container(),), // 空白填充
                    Text(
                      '拒绝',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 15,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    Expanded(child: Container(),), // 空白填充
                  ],),
                ),
                Expanded(child: Container(),), // 空白填充
              ],),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                    child: null,
                    color: Colors.transparent,
                    onPressed: () {},
                  ),
                ),
              ),
            ],),
            Expanded(child: Container(),), // 空白填充
          ],),
        ),
        Container(width: 40,), // 空白填充
      ],),
    );
  }

  static Divider singleFriendManageCardDivider(){
    return Divider(
      indent: 40,
      endIndent: 40,
      height: 1,
      color: Color(0xffFFFFFF),
    );
  }

  static Container singleFriendManageSendRequestCard(
      Image friendAvatar,
      String friendName,
      )
  {
    return Container(
      height: 100,
      child: Row(children: [
        Container(width: 40,), // 空白填充
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
                spreadRadius: 2.0, // 阴影扩散程度
              ),
            ],
          ),
          child: ClipOval(child: friendAvatar, ),
        ),
        Container(width: 20,), // 空白填充
        Container(child: Column(children: [
          Expanded(child: Container(),), // 空白填充
          Text(
            friendName,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 20,
              color: Color(0xffffffff),
            ),
          ),
          Expanded(child: Container(),), // 空白填充
        ],),),
        Expanded(child: Container(),), // 空白填充
        Container(
          width: 70,
          child: Column(children: [
            Expanded(child: Container(),), // 空白填充
            Stack(children: [
              Row(children: [
                Expanded(child: Container(),), // 空白填充
                Container(
                  height: 30,
                  child: Column(children: [
                    Expanded(child: Container(),), // 空白填充
                    Text(
                      '撤销',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 15,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Expanded(child: Container(),), // 空白填充
                  ],),
                ),
                Expanded(child: Container(),), // 空白填充
              ],),
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xffffffff),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                    child: null,
                    color: Colors.transparent,
                    onPressed: () {},
                  ),
                ),
              ),
            ],),
            Expanded(child: Container(),), // 空白填充
          ],),
        ),
        Container(width: 40,), // 空白填充
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

  static TextField singleDialogTextField(String hintTextInput,) {
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
      cursorColor: Color(0xffffa200),
      maxLines: 1,
      // controller: ,
      style: TextStyle(
        fontFamily: "Hiragino Sans GB",
        fontSize: 16.0,
        color: Color(0xff9b9b9b),
      ),
      // keyboardType: TextInputType.number,
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

  static Container singleFriendsManagePage(BuildContext context){
    if(pageState == 1){
      return Container(child: ListView(children: [
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar1.png'),
          '小卡',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar2.png'),
          '是多多呀',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar3.png'),
          '热心市民灰灰',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar4.png'),
          'Gretal',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar5.png'),
          'John Kim',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar1.png'),
          '小卡',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar2.png'),
          '是多多呀',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar3.png'),
          '热心市民灰灰',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar4.png'),
          'Gretal',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar5.png'),
          'John Kim',
        ),
        singleFriendManageCardDivider(),
      ],),);
    }else if(pageState == 2){
      if(ifPage4Null == true){
        return Container(child: Column(children: [
          Expanded(flex: 3, child: Container(),), // 空白填充
          Text(
            '没有待处理的交友申请',
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "Hiragino Sans GB",
              fontSize: 14,
              color: Color(0x9E000000),
            ),
          ),
          Expanded(flex: 4, child: Container(),), // 空白填充
        ],),);
      }
      return Container(child: ListView(children: [
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar1.png'),
          '小卡',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar2.png'),
          '是多多呀',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar3.png'),
          '热心市民灰灰',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar4.png'),
          'Gretal',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar5.png'),
          'John Kim',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar1.png'),
          '小卡',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar2.png'),
          '是多多呀',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar3.png'),
          '热心市民灰灰',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar4.png'),
          'Gretal',
        ),
        singleFriendManageCardDivider(),
        singleFriendManageRequestCard(
          Image.asset('assets/images/FriendsManagePage/testAvatar5.png'),
          'John Kim',
        ),
        singleFriendManageCardDivider(),
      ],),);
    }else if(pageState == 3){
      return Container(child: Column(
        children: [
          Row(children: [
            Container(width: 40,), // 空白填充
            Expanded(child: Column(children: [
              Container(height: 10,), // 空白填充
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: dialogTitle('请输入好友的Calories账号'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  singleDialogTextField('电子信箱'),
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
                                child: dialogButtonText('加入'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  },
                  child: Row(children: [
                    Container(width: 10,), // 空白填充
                    Text(
                      '通过Calorie账号加好友',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Expanded(child: Container(),), // 空白填充
                    Icon(Icons.add, color: Color(0xffffffff),),
                    Container(width: 10,), // 空白填充
                  ],),
                ),
              ),
              Divider(height: 1, color: Color(0xffFFFFFF),),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: (){},
                  child: Row(children: [
                    Container(width: 10,), // 空白填充
                    Text(
                      '等待接受邀请',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Expanded(child: Container(),), // 空白填充
                    Container(width: 10,), // 空白填充
                    Text(
                      '10',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "Hiragino Sans GB",
                        fontSize: 18,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Container(width: 10,), // 空白填充
                    Icon(Icons.keyboard_arrow_down, color: Color(0xffffffff),),
                    Container(width: 10,), // 空白填充
                  ],),
                ),
              ),
              Divider(height: 1, color: Color(0xffFFFFFF),),
            ],),),
            Container(width: 40,), // 空白填充
          ],),
          Expanded(child: Container(
            width: double.infinity,
            height: double.infinity,
            child: ListView(children: [
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar1.png'),
                '小卡',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar2.png'),
                '是多多呀',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar3.png'),
                '热心市民灰灰',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar4.png'),
                'Gretal',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar5.png'),
                'John Kim',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar1.png'),
                '小卡',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar2.png'),
                '是多多呀',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar3.png'),
                '热心市民灰灰',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar4.png'),
                'Gretal',
              ),
              singleFriendManageCardDivider(),
              singleFriendManageSendRequestCard(
                Image.asset('assets/images/FriendsManagePage/testAvatar5.png'),
                'John Kim',
              ),
            ],),
          ),)
        ],
      ),);
    }
    return Container();
  }

  static var _refreshFriendsManagePage = RefreshableView(
      builder: (BuildContext context)
      {return singleFriendsManagePage(context);}
  );

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
                Expanded(child: Container(color: Color(0xffFFA200),),),
              ],),
            ],),
            Column(children: [
              appBarReturn(context, size),
              _refreshFriendsManageButtonBar,
              Expanded(child: _refreshFriendsManagePage,),
            ],),
          ],),
        ),
      ),
    );
  }
}