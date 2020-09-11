import 'package:json_annotation/json_annotation.dart';

part 'author_data.g.dart';

@JsonSerializable(nullable: false)
class AuthorData {
  String id;
  String photoUrl;
  String username;

  AuthorData({this.id, this.photoUrl, this.username});

  factory AuthorData.fromJson(Map<String, dynamic> json) => _$AuthorDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorDataToJson(this);
}