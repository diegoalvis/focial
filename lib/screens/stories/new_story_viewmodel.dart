import 'package:flutter/cupertino.dart';
import 'package:focial/models/story.dart';
import 'package:focial/utils/gradients.dart';
import 'package:focial/utils/text_styles.dart';

class NewStoryViewmodel extends ChangeNotifier {
  int _currentGradientIndex = 0;
  int _currentTextStyleIndex = 0;

  bool _textColorWhite = false;
  final textEditingController = TextEditingController();

  void changeGradient() {
    _currentGradientIndex =
        (_currentGradientIndex + 1) % Gradients.gradients.length;
    notifyListeners();
  }

  void toggleColor() {
    _textColorWhite = !_textColorWhite;
    notifyListeners();
  }

  void changeTextStyle() {
    _currentTextStyleIndex =
        (_currentTextStyleIndex + 1) % StoryTextStyles.styles.length;
    notifyListeners();
  }

  void post() {
    Story story = Story(
      content: textEditingController.text,
      gradient: _currentGradientIndex,
      textStyle: _currentTextStyleIndex,
      whiteText: _textColorWhite,
    );
    print(story);
  }

  bool get textColorWhite => _textColorWhite;

  set textColorWhite(bool value) {
    _textColorWhite = value;
    notifyListeners();
  }

  int get currentTextStyleIndex => _currentTextStyleIndex;

  set currentTextStyleIndex(int value) {
    _currentTextStyleIndex = value;
    notifyListeners();
  }

  int get currentGradientIndex => _currentGradientIndex;

  set currentGradientIndex(int value) {
    _currentGradientIndex = value;
    notifyListeners();
  }
}
