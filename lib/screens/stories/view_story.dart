import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:focial/models/story.dart';
import 'package:focial/screens/stories/new_story.dart';
import 'package:focial/screens/stories/view_story_viewmodel.dart';
import 'package:focial/utils/text_styles.dart';
import 'package:stacked/stacked.dart';

class ViewStoriesScreen extends StatefulWidget {
  final Story story;

  const ViewStoriesScreen({Key key, this.story}) : super(key: key);

  @override
  _ViewStoriesScreenState createState() => _ViewStoriesScreenState();
}

class _ViewStoriesScreenState extends State<ViewStoriesScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Curves.linear,
        parent: _controller,
      ),
    );
    super.initState();
    // _controller.addListener(() {
    //   // print(_animation.value);
    // });
    _listenToGestures();
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) Navigator.of(context).pop();
    });
  }

  final Map<Type, GestureRecognizerFactory> gestures =
      <Type, GestureRecognizerFactory>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawGestureDetector(
        gestures: gestures,
        behavior: HitTestBehavior.translucent,
        child: ViewModelBuilder<ViewStoryViewmodel>.reactive(
          viewModelBuilder: () => ViewStoryViewmodel(),
          onModelReady: (m) => m.init(context),
          builder: (context, model, child) => Stack(
            children: [
              GradientBackground(
                index: widget.story.gradient,
              ),
              Center(
                child: Text(
                  widget.story.text,
                  style: StoryTextStyles.styles[widget.story.textStyle],
                ),
              ),
              Positioned(
                top: 8.0,
                left: 8.0,
                child: SafeArea(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.0,
                        backgroundImage: CachedNetworkImageProvider(
                            "https://avatars3.githubusercontent.com/u/35001172?s=460&u=ed19790a0421a2e296d2e1faac50e40468669896&v=4"),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'fayaz07',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                top: 100.0,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _animation.value,
                      // backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLongPressStart(LongPressStartDetails details) {
    _controller.stop();
    print("stopping animation at ${_animation.value}");
  }

  void onLongPressEnd(LongPressEndDetails details) {
    print("restarting animation at ${_animation.value}");
    _controller.forward(from: _animation.value);
  }

  void _listenToGestures() {
    gestures[LongPressGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
      () => LongPressGestureRecognizer(
          debugOwner: this, duration: Duration(milliseconds: 50)),
      (LongPressGestureRecognizer instance) {
        instance
              // ..onLongPress = onLongPress
              ..onLongPressStart = onLongPressStart
              // ..onLongPressMoveUpdate = onLongPressMoveUpdate
              ..onLongPressEnd = onLongPressEnd
            // ..onLongPressUp = onLongPressUp
            ;
      },
    );
  }
}
