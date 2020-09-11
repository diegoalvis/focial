// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorData _$AuthorDataFromJson(Map<String, dynamic> json) {
  return AuthorData(
    id: json['id'] as String,
    photoUrl: json['photoUrl'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$AuthorDataToJson(AuthorData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'photoUrl': instance.photoUrl,
      'username': instance.username,
    };
