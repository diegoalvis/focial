// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$FocialAPI extends FocialAPI {
  _$FocialAPI([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FocialAPI;

  @override
  Future<Response<dynamic>> register(
      {String name, String email, String password}) {
    final $url = 'auth/register';
    final $body = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> login({String email, String password}) {
    final $url = 'auth/login';
    final $body = <String, dynamic>{'email': email, 'password': password};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> resendAccountVerifyLink(
      {String email, String password}) {
    final $url = 'auth/token/resend';
    final $body = <String, dynamic>{'email': email, 'password': password};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUser() {
    final $url = 'user';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateUser(Map<String, dynamic> body) {
    final $url = 'user';
    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> checkUsername(String username) {
    final $url = 'user/check/$username';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadProfilePicture(String file) {
    final $url = 'user/pp';
    final $parts = <PartValue>[PartValueFile<String>('file', file)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadCoverPicture(String file) {
    final $url = 'user/cover';
    final $parts = <PartValue>[PartValueFile<String>('file', file)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getStoryFeed() {
    final $url = 'story';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> newStory(Map<String, dynamic> body) {
    final $url = 'story';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> newPost(Map<String, dynamic> body) {
    final $url = 'post';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadPostImage(String file) {
    final $url = 'post/image';
    final $parts = <PartValue>[PartValueFile<String>('file', file)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
