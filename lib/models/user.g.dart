// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['userId'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    gender: json['gender'] as String,
    bio: json['bio'] as String,
    username: json['username'] as String,
    coverPic: json['coverPic'] as String,
    age: json['age'] as int,
    location: json['location'],
    photoUrl: json['photoUrl'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    posts: json['posts'] as int,
    followers: json['followers'].length as int,
    following: json['following'].length as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'coverPic': instance.coverPic,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'bio': instance.bio,
      'age': instance.age,
      'location': instance.location,
      'photoUrl': instance.photoUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'posts': instance.posts,
      'followers': instance.followers,
      'following': instance.following,
    };
