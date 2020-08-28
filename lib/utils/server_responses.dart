import 'dart:convert';

import 'package:chopper/chopper.dart';

const String TOKEN = "token";
const String ACCESS_TOKEN = "access_token";
const String REFRESH_TOKEN = "refresh_token";
const String EMAIL = "email";
const String PASSWORD = "password";
const String EXPIRED = "Expired";
const String EXPIRE = "expire";
const String MESSAGE = "message";

class ServerResponse {
  static String getMessage(Response response) {
    return response.isSuccessful
        ? response.body[MESSAGE]
        : json.decode(response.error.toString())[MESSAGE];
  }
}
