import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/stories/new_story_viewmodel.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/gradients.dart';
import 'package:focial/utils/text_styles.dart';
import 'package:focial/widgets/button.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(home: NewStory()));

class NewStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NewStoryViewmodel>(context);

    return PlatformScaffold(
      body: Stack(
        children: [
          _gradientBackground(controller),
          _gradientChangeButton(controller),
          _changeTextStyleButton(controller),
          _toggleColorButton(controller),
          _postStoryButton(controller),
          _textField(controller, context),
        ],
      ),
    );
  }

  Widget _gradientBackground(NewStoryViewmodel controller) => Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Gradients.gradients[controller.currentGradientIndex],
            ),
          ),
        ),
      );

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

  Widget _textField(NewStoryViewmodel controller, BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textEditingController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    maxLength: 160,
                    maxLines: null,
                    expands: true,
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
              ],
            ),
          ),
        ),
      );
}
