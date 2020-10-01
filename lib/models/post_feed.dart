import 'package:focial/models/author_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_feed.g.dart';

@JsonSerializable(nullable: false)
class PostFeed {
  @JsonKey(name: '_id')
  String id;
  int type;
  @JsonKey(name: "user")
  AuthorData authorData;
  String caption;
  List<String> images;
  int likes;
  bool liked;
  List<String> likedBy;

  PostFeed(
      {this.id,
      this.type,
      this.authorData,
      this.caption,
      this.images,
      this.likes = 0,
      this.liked,
      this.likedBy});

  factory PostFeed.fromJson(Map<String, dynamic> json) =>
      _$PostFeedFromJson(json);

  Map<String, dynamic> toJson() => _$PostFeedToJson(this);

  static List<PostFeed> parseListFromJson(var jsonList) {
    List<PostFeed> res = [];
    for (var l in jsonList) {
      res.add(PostFeed.fromJson(l));
    }
    return res;
  }
}
