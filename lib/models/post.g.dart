// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FocialPost _$FocialPostFromJson(Map<String, dynamic> json) {
  return FocialPost(
    id: json['_id'] as String,
    type: json['type'] as int,
    authorData: AuthorData.fromJson(json['authorData'] as Map<String, dynamic>),
    caption: json['caption'] as String,
    images: (json['images'] as List).map((e) => e as String).toList(),
    likes: (json['likes'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$FocialPostToJson(FocialPost instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'authorData': instance.authorData,
      'caption': instance.caption,
      'images': instance.images,
      'likes': instance.likes,
    };
