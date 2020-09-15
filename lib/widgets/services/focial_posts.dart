import 'package:flutter/cupertino.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/post.dart';
import 'package:stacked/stacked.dart';

class FocialPosts extends StatelessWidget {
  final Function(BuildContext, FocialPostService, Widget) builder;
  final Widget child;

  const FocialPosts({Key key, this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => find<FocialPostService>(),
      disposeViewModel: false,
      onModelReady: (m) => {},
      staticChild: child,
      builder: builder,
    );
  }
}
