// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryView _$StoryViewFromJson(Map<String, dynamic> json) {
  return StoryView(
    viewer: AuthorData.fromJson(json['viewer'] as Map<String, dynamic>),
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$StoryViewToJson(StoryView instance) => <String, dynamic>{
      'viewer': instance.viewer,
      'timestamp': instance.timestamp.toIso8601String(),
    };
