import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  @JsonKey(name: "userId")
  String id;
  String firstName;
  String lastName;
  String coverPic;
  String email;
  String gender;
  String bio;
  int age;
  List knownLanguages;
  String profession;
  var location;
  String photoUrl;
  double latitude;
  double longitude;

  int posts;
  int followers;
  int following;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.bio,
      this.coverPic,
      this.age,
      this.knownLanguages,
      this.profession,
      this.location,
      this.photoUrl,
      this.latitude,
      this.longitude,
      this.posts,
      this.followers,
      this.following});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, bio: $bio, age: $age, knownLanguages: $knownLanguages, profession: $profession, location: $location, photoUrl: $photoUrl, latitude: $latitude, longitude: $longitude, posts: $posts, followers: $followers, following: $following}';
  }
}
