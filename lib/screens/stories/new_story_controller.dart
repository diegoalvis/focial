import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/story.dart';
import 'package:focial/utils/gradients.dart';
import 'package:focial/utils/text_styles.dart';

/*
-------------------------------------------------------------------------------
--------------------------------------Events-----------------------------------
-------------------------------------------------------------------------------
 */
abstract class NewStoryEvent {}

class ChangeBackground extends NewStoryEvent {}

class ChangeTextStyle extends NewStoryEvent {}

class ToggleColor extends NewStoryEvent {}

class Post extends NewStoryEvent{
  BuildContext context;

  Post(this.context);
}

/*
-------------------------------------------------------------------------------
--------------------------------------State------------------------------------
-------------------------------------------------------------------------------
 */
class NewStoryState {
  int currentGradientIndex = 0;
  int currentTextStyleIndex = 0;

  bool textColorWhite = false;

  NewStoryState(
      {this.currentGradientIndex=0,
      this.currentTextStyleIndex=0,
      this.textColorWhite=false});

  NewStoryState copyWith(
      {int currentGradientIndex,
      int currentTextStyleIndex,
      bool textColorWhite}) {
    return NewStoryState(
      currentGradientIndex: currentGradientIndex ?? this.currentGradientIndex,
      currentTextStyleIndex:
          currentTextStyleIndex ?? this.currentTextStyleIndex,
      textColorWhite: textColorWhite ?? this.textColorWhite,
    );
  }
}

/*
-------------------------------------------------------------------------------
--------------------------------------Bloc-------------------------------------
-------------------------------------------------------------------------------
 */
class NewStoryBloc extends Bloc<NewStoryEvent, NewStoryState> {
  NewStoryBloc() : super(NewStoryState());

  final textEditingController = TextEditingController();

  @override
  Stream<NewStoryState> mapEventToState(NewStoryEvent event) async* {
    if (event is ChangeBackground)
      yield state.copyWith(
        currentGradientIndex:
            (state.currentGradientIndex + 1) % Gradients.gradients.length,
      );

    if (event is ToggleColor)
      yield state.copyWith(textColorWhite: !state.textColorWhite);

    if (event is ChangeTextStyle)
      yield state.copyWith(
        currentTextStyleIndex:
            (state.currentTextStyleIndex + 1) % StoryTextStyles.styles.length,
      );

    if(event is Post){
      Story story = Story(
        content: textEditingController.text,
        gradient: state.currentGradientIndex,
        textStyle: state.currentTextStyleIndex,
        whiteText: state.textColorWhite,
      );
      print(story);
    }
  }
}
