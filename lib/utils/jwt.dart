import 'dart:convert';

const EXP = "exp";

class JWT {
  static Map<String, dynamic> decode(String token) {
    if (token == null) return null;
    final parts = token.split('.');
    if (parts.length != 3) return null;

    final payload = parts[1];

    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }

    return payloadMap;
  }

  static bool isExpired(String token) {
    Map<String, dynamic> decodedToken = decode(token);
    if (DateTime.fromMillisecondsSinceEpoch(decodedToken[EXP] * 1000)
        .isAfter(DateTime.now())) {
      return true;
    }
    // payload expired, refresh the token and continue
    return false;
  }
}
