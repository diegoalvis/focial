import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

enum StoryType { Text }

@JsonSerializable(nullable: false)
class Story {
  String content;
  int gradient;
  int textStyle;
  bool whiteText;

  Story(
      {this.content,
      this.gradient = 0,
      this.textStyle = 0,
      this.whiteText = false});

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  @override
  String toString() {
    return 'Story{content: $content, gradient: $gradient, textStyle: $textStyle, whiteText: $whiteText}';
  }
}
