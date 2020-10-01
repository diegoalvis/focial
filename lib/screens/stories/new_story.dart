import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/stories/new_story_viewmodel.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/gradients.dart';
import 'package:focial/utils/text_styles.dart';
import 'package:focial/widgets/button.dart';
import 'package:stacked/stacked.dart';

class NewStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewStoryViewmodel>.reactive(
      viewModelBuilder: () => NewStoryViewmodel(),
      onModelReady: (m) => m.init(context),
      builder: (context, controller, child) => PlatformScaffold(
        body: Stack(
          children: [
            // _gradientBackground(controller),
            GradientBackground(index: controller.currentGradientIndex),
            _gradientChangeButton(controller),
            _changeTextStyleButton(controller),
            _toggleColorButton(controller),
            _postStoryButton(controller),
            _textField(controller, context),
          ],
        ),
      ),
    );
  }

  Widget _gradientChangeButton(NewStoryViewmodel controller) => Positioned(
        bottom: 26.0,
        left: 24.0,
        height: 32.0,
        width: 32.0,
        child: InkWell(
          onTap: controller.changeGradient,
          child: Material(
              type: MaterialType.circle,
              color: Colors.transparent,
              shadowColor: Colors.grey.withOpacity(0.4),
              elevation: 4.0,
              child: Image.asset(Assets.COLOR_WHEEL)),
        ),
      );

  Widget _changeTextStyleButton(NewStoryViewmodel controller) => Positioned(
        bottom: 26.0,
        left: 70.0,
        height: 32.0,
        width: 32.0,
        child: InkWell(
          onTap: controller.changeTextStyle,
          child: Material(
            type: MaterialType.transparency,
            child: Image.asset(Assets.TEXT),
          ),
        ),
      );

  Widget _toggleColorButton(NewStoryViewmodel controller) => Positioned(
        bottom: 26.0,
        left: 110.0,
        height: 32.0,
        width: 32.0,
        child: InkWell(
          onTap: controller.toggleColor,
          child: Material(
            type: MaterialType.transparency,
            child: Image.asset(Assets.TEXT_COLOR),
          ),
        ),
      );

  Widget _postStoryButton(NewStoryViewmodel controller) => Positioned(
        bottom: 20.0,
        right: 32.0,
        height: 45.0,
        width: 100.0,
        child: AppPlatformButton(
          color: Colors.blue,
          onPressed: controller.post,
          elevation: 8.0,
          borderRadius: 32.0,
          text: 'SEND',
        ),
      );

  Widget _textField(NewStoryViewmodel controller, BuildContext context) =>
      Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50.0,
            maxHeight: 350.0,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            child: Center(
              child: TextFormField(
                scrollPhysics: NeverScrollableScrollPhysics(),
                controller: controller.textEditingController,
                autofocus: true,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                maxLength: 160,
                expands: true,
                maxLines: null,
                style: StoryTextStyles.styles[controller.currentTextStyleIndex]
                    .apply(
                        color: controller.textColorWhite
                            ? Colors.white
                            : Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counter: SizedBox(),
                ),
              ),
            ),
          ),
        ),
      );
}

class GradientBackground extends StatelessWidget {
  final int index;

  const GradientBackground({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Gradients.gradients[index],
          ),
        ),
      ),
    );
  }
}
