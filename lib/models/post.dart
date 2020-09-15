import 'package:focial/models/author_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(nullable: false)
class FocialPost {
  @JsonKey(name: '_id')
  String id;
  int type;
  AuthorData authorData;
  String caption;
  List<String> images;
  List<String> likes;

  FocialPost(
      {this.id,
      this.type,
      this.authorData,
      this.caption,
      this.images,
      this.likes});

  factory FocialPost.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
