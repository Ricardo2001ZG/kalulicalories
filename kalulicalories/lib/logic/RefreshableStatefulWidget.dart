
import 'package:flutter/material.dart';

// 刷新
// _aRefreshableView.reload();
abstract class RefreshableStatefulWidget extends StatefulWidget {
  RefreshableStatefulWidget({Key key})
      : super(key: key is GlobalKey ? key : GlobalKey());
  void reload() {
    if (key is! GlobalKey) {
      return;
    }
    final aKey = key as GlobalKey;
    // ignore: invalid_use_of_protected_member
    aKey.currentState.setState(() {});
  }
}

class RefreshableView extends RefreshableStatefulWidget {
  final Widget Function(BuildContext context) builder;
  RefreshableView({Key key, this.builder})
      : assert(builder != null),
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RefreshableViewState(builder);
  }
}

class _RefreshableViewState extends State<RefreshableView> {
  final Widget Function(BuildContext context) builder;
  _RefreshableViewState(this.builder);
  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
// 刷新类实现结束