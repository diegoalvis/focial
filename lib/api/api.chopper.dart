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
}
