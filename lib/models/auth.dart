import 'package:focial/utils/jwt.dart';

class Auth {
  String accessToken;
  String refreshToken;
  bool isLoggedIn, isTokenValid, isSessionValid;

  Auth({this.accessToken, this.refreshToken}) {
    this.isLoggedIn = _checkLoggedIn();
    this.isTokenValid = _checkExpiryOfToken();
    this.isSessionValid = _checkExpiryOfSession();
    // print("For $accessToken ${accessToken.isValidByLength()}");
    // print("For $refreshToken ${refreshToken.isValidByLength()}");
    // print("&& ${accessToken.isValidByLength() && refreshToken.isValidByLength()}");
  }

  bool _checkLoggedIn() =>
      accessToken.isValidByLength() && refreshToken.isValidByLength();

  bool _checkExpiryOfToken() {
    if (accessToken.isValidByLength()) return JWT.isExpired(accessToken);
    return false;
  }

  bool _checkExpiryOfSession() {
    if (refreshToken.isValidByLength()) return JWT.isExpired(refreshToken);
    return false;
  }

  Auth copyWith({String accessToken, String refreshToken}) {
    return Auth(accessToken: accessToken, refreshToken: refreshToken);
  }

  @override
  String toString() {
    return 'Auth{accessToken: $accessToken, refreshToken: $refreshToken, isLoggedIn: $isLoggedIn, isTokenValid: $isTokenValid, isSessionValid: $isSessionValid}';
  }
}

extension TokenValidity on String {
  bool isValidByLength() {
    if (this == null) return false;

    if (this.length < 200) return false;

    return true;
  }
}
