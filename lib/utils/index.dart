import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

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

class Utils {}
