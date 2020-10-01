import 'package:focial/models/author_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_view.g.dart';

@JsonSerializable(nullable: false)
class StoryView {
  AuthorData viewer;
  DateTime timestamp;

  StoryView({this.viewer, this.timestamp});

  factory StoryView.fromJson(Map<String, dynamic> json) => _$StoryViewFromJson(json);

  Map<String, dynamic> toJson() => _$StoryViewToJson(this);
}