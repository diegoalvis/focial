import 'package:flutter/material.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';
import 'package:stacked/stacked.dart';

class UserDataWidget extends StatelessWidget {
  final Function(BuildContext, UserData, Widget) builder;
  final Widget child;

  const UserDataWidget({Key key, this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserData>.reactive(
      viewModelBuilder: () => find<UserData>(),
      disposeViewModel: false,
      staticChild: child,
      builder: builder,
    );
  }
}
