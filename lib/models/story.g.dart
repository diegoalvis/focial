// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    text: json['text'] as String,
    gradient: json['gradient'] as int,
    textStyle: json['textStyle'] as int,
    colorHex: json['colorHex'] as String,
    views: (json['views'] as List)
        .map((e) => StoryView.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..storyId = json['storyId'] as String;
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'storyId': instance.storyId,
      'text': instance.text,
      'gradient': instance.gradient,
      'textStyle': instance.textStyle,
      'colorHex': instance.colorHex,
      'views': instance.views,
    };
