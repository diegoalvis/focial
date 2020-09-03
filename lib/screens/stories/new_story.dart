import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/stories/new_story_controller.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/gradients.dart';
import 'package:focial/utils/text_styles.dart';
import 'package:focial/widgets/button.dart';

void main() => runApp(MaterialApp(home: NewStory()));

class NewStory extends StatefulWidget {
  @override
  _NewStoryState createState() => _NewStoryState();
}

class _NewStoryState extends State<NewStory> {
  final bloc = NewStoryBloc();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: BlocBuilder<NewStoryBloc, NewStoryState>(
        cubit: bloc,
        builder: (context, state) => Stack(
          children: [
            _gradientBackground(state),
            _gradientChangeButton(state),
            _changeTextStyleButton(state),
            _toggleColorButton(state),
            _postStoryButton(state),
            _textField(state),
          ],
        ),
      ),
    );
  }

  Widget _gradientBackground(NewStoryState state) => Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Gradients.gradients[state.currentGradientIndex],
            ),
          ),
        ),
      );

  Widget _gradientChangeButton(NewStoryState state) => Positioned(
        bottom: 26.0,
        left: 24.0,
        height: 32.0,
        width: 32.0,
        child: InkWell(
          onTap: () => bloc.add(ChangeBackground()),
          child: Material(
              type: MaterialType.circle,
              color: Colors.transparent,
              shadowColor: Colors.grey.withOpacity(0.4),
              elevation: 4.0,
              child: Image.asset(Assets.COLOR_WHEEL)),
        ),
      );

  Widget _changeTextStyleButton(NewStoryState state) => Positioned(
        bottom: 26.0,
        left: 70.0,
        height: 32.0,
        width: 32.0,
        child: InkWell(
          onTap: () => bloc.add(ChangeTextStyle()),
          child: Material(
            type: MaterialType.transparency,
            child: Image.asset(Assets.TEXT),
          ),
        ),
      );

  Widget _toggleColorButton(NewStoryState state) => Positioned(
        bottom: 26.0,
        left: 110.0,
        height: 32.0,
        width: 32.0,
        child: InkWell(
          onTap: () => bloc.add(ToggleColor()),
          child: Material(
            type: MaterialType.transparency,
            child: Image.asset(Assets.TEXT_COLOR),
          ),
        ),
      );

  Widget _postStoryButton(NewStoryState state) => Positioned(
        bottom: 20.0,
        right: 32.0,
        height: 45.0,
        width: 100.0,
        child: AppPlatformButton(
          color: Colors.blue,
          onPressed: ()=>bloc.add(Post(context)),
          elevation: 8.0,
          borderRadius: 32.0,
          text: 'SEND',
        ),
      );

  Widget _textField(NewStoryState state) => Center(
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
                    controller: bloc.textEditingController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    maxLength: 160,
                    maxLines: null,
                    expands: true,
                    style: StoryTextStyles.styles[state.currentTextStyleIndex]
                        .apply(
                            color: state.textColorWhite
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
