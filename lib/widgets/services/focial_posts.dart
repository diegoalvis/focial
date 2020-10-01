import 'package:flutter/cupertino.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/post_feed.dart';
import 'package:stacked/stacked.dart';

class PostFeed extends StatelessWidget {
  final Function(BuildContext, PostFeedService, Widget) builder;
  final Widget child;

  const PostFeed({Key key, this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => find<PostFeedService>(),
      disposeViewModel: false,
      onModelReady: (m) => {},
      staticChild: child,
      builder: builder,
    );
  }
}
