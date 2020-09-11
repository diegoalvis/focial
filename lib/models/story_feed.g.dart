// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryFeed _$StoryFeedFromJson(Map<String, dynamic> json) {
  return StoryFeed(
    authorData: AuthorData.fromJson({
      "id": json["_id"],
      "username": json["username"],
      "photoUrl": json["photoUrl"]
    }),
    stories: (json['stories'] as List)
        .map((e) => Story.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StoryFeedToJson(StoryFeed instance) => <String, dynamic>{
      'authorData': instance.authorData,
      'stories': instance.stories,
    };
