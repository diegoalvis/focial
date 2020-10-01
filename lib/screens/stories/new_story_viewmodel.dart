import 'package:flutter/cupertino.dart';
import 'package:focial/models/story.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/story.dart';
import 'package:focial/utils/gradients.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/server_responses.dart';
import 'package:focial/utils/text_styles.dart';

class NewStoryViewmodel extends ChangeNotifier {
  int _currentGradientIndex = 0;
  int _currentTextStyleIndex = 0;
  BuildContext _context;

  bool _textColorWhite = false;
  final textEditingController = TextEditingController();

  void init(BuildContext context) {
    _context = context;
  }

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

  Future<void> post() async {
    Story story = Story(
      text: textEditingController.text,
      gradient: _currentGradientIndex,
      textStyle: _currentTextStyleIndex,
      colorHex: _textColorWhite ? "ffffff" : "000000",
    );
    print(story);
    final response = await find<StoryService>().newStory(story);
    if (response.isSuccessful) {
      Navigator.of(_context).pop();
    } else {
      AppOverlays.showError(
          "Server response", ServerResponse.getMessage(response));
    }
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
