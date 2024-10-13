import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  final storage = const FlutterSecureStorage();
  final String baseUrl;

  //AuthRepository({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  AuthRepository({this.baseUrl = '10.0.2.2'}); // Android Simulator

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    var response = await http.post(
      Uri.parse("http://$baseUrl:8000/users/"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      // คุณอาจจะได้รับ token หรือข้อมูลอื่นๆ ในกรณีที่การสมัครสำเร็จ
      final Map<String, dynamic> result = jsonDecode(response.body);

      // เก็บ token ใน secure storage ถ้า API ส่งมา
      if (result.containsKey('token')) {
        await storage.write(key: 'token', value: result['token']);
      }

      return;
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      if (result['detail'] == "Email already exists") {
        throw Exception("Email already exists");
      } else if (result['detail'] == "Passwords do not match") {
        throw Exception("Passwords do not match");
      } else if (result['detail'] == "username already exists") {
        throw Exception("Username already exists");
      } else if (result['detail'] is List) {
        // กรณีที่ response เป็น List ของ validation errors
        throw Exception(result['detail'].map((e) => e['msg']).join(', '));
      } else {
        throw Exception("Unknown error: ${result['detail']}");
      }
    } else {
      throw Exception("Failed to authenticate: ${response.body}");
    }
  }

  Future<void> signInUser({
    required String username,
    required String password,
  }) async {
    var response = await http.post(
      Uri.parse("http://10.0.2.2:8000/token"),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        "username": username,
        "password": password,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Store the token securely
      String? accessToken = data['access_token'];
      if (accessToken != null) {
        await storage.write(key: "accesstoken", value: accessToken);
        // Check token
        String? storedToken = await storage.read(key: "accesstoken");
        if (storedToken != null) {
          return;
        } else {
          throw Exception("Access token not stored");
        }
      }
    } else {
      throw Exception("Failed to authenticate: ${response.body}");
    }
  }
}
