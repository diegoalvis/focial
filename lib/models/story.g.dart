// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    content: json['content'] as String,
    gradient: json['gradient'] as int,
    textStyle: json['textStyle'] as int,
    whiteText: json['whiteText'] as bool,
  );
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'content': instance.content,
      'gradient': instance.gradient,
      'textStyle': instance.textStyle,
      'whiteText': instance.whiteText,
    };
