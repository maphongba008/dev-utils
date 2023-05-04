import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:crypto/crypto.dart';

String formatJSON(String json) {
  try {
    Map<String, dynamic> data = jsonDecode(json);
    return JsonEncoder.withIndent("    ").convert(data);
  } catch (e) {
    return "Invalid JSON";
  }
}

String base64Encoder(String text) {
  try {
    return base64Encode(utf8.encode(text));
  } catch (e) {
    return "";
  }
}

String base64Decoder(String text) {
  try {
    return utf8.decode(base64Decode(text));
  } catch (e) {
    return "";
  }
}

String jwtDecoder(String token) {
  try {
    final jwt = JWT.decode(token.replaceAll("Bearer ", ""));
    Map<String, dynamic> map = {
      "header": jwt.header,
      "payload": jwt.payload,
    };
    return JsonEncoder.withIndent("    ").convert(map);
  } catch (e) {
    return "";
  }
}

String urlEncoder(String text) {
  try {
    return Uri.encodeFull(text);
  } catch (e) {
    return "";
  }
}

String urlDecoder(String text) {
  try {
    return Uri.decodeFull(text);
  } catch (e) {
    return "";
  }
}

String generateMd5(String data) {
  return md5.convert(utf8.encode(data)).toString();
}

String generateSHA1(String data) {
  return sha1.convert(utf8.encode(data)).toString();
}
