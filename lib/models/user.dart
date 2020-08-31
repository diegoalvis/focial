import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  @JsonKey(name: "userId")
  String id;
  String username;
  String firstName;
  String lastName;
  String coverPic;
  String email;
  String phone;
  String gender;
  String bio;
  int age;
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
      this.phone,
      this.gender,
      this.bio,
      this.username,
      this.coverPic,
      this.age,
      this.location,
      this.photoUrl,
      this.latitude,
      this.longitude,
      this.posts,
      this.followers,
      this.following});

  User copyWith(
      {String username,
      String firstName,
      String lastName,
      String coverPic,
      String email,
      String phone,
      String gender,
      String bio,
      int age,
      var location,
      String photoUrl,
      double latitude,
      double longitude,
      int posts,
      int followers,
      int following}) {
    return User(
      id: this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      username: username ?? this.username,
      coverPic: coverPic ?? this.coverPic,
      age: age ?? this.age,
      location: location ?? this.location,
      photoUrl: photoUrl ?? this.photoUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      posts: posts ?? this.posts,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, username: $username, firstName: $firstName, lastName: $lastName, coverPic: $coverPic, email: $email, phone: $phone, gender: $gender, bio: $bio, age: $age, location: $location, photoUrl: $photoUrl, latitude: $latitude, longitude: $longitude, posts: $posts, followers: $followers, following: $following}';
  }
}
