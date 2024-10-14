import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:moody/blocs/signup_bloc/auth_app.dart';

class AuthRepository {
  final storage = const FlutterSecureStorage();
  final String baseUrl;

  //AuthRepository({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  AuthRepository({this.baseUrl = '10.0.2.2'}); // Android Simulator

  Future<User> signUp({
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
      // Assuming you receive some token or user data in the response
      final Map<String, dynamic> result = jsonDecode(response.body);

      // Store token if available
      if (result.containsKey('token')) {
        await storage.write(key: 'token', value: result['token']);
      }

      // Assuming the response contains the user data, create and return the user
      return User(
        username: result['username'],
        email: result['email'],
      );
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      if (result['detail'] == "Email already exists") {
        throw Exception("Email already exists");
      } else if (result['detail'] == "Passwords do not match") {
        throw Exception("Passwords do not match");
      } else if (result['detail'] == "username already exists") {
        throw Exception("Username already exists");
      } else if (result['detail'] is List) {
        throw Exception(result['detail'].map((e) => e['msg']).join(', '));
      } else {
        throw Exception("Unknown error: ${result['detail']}");
      }
    } else {
      throw Exception("Failed to sign up: ${response.body}");
    }
  }

  Future<User> signInUser({
    required String username,
    required String password,
  }) async {
    var response = await http.post(
      Uri.parse("http://$baseUrl:8000/token"),
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
      String? accessToken = data['access_token'];

      if (accessToken != null) {
        await storage.write(key: "accesstoken", value: accessToken);

        // Fetch the current user data after successful sign-in
        return await getMeUser();
      } else {
        throw Exception("Access token not found");
      }
    } else {
      throw Exception("Failed to authenticate: ${response.body}");
    }
  }

  Future<User> getMeUser() async {
    final url = Uri.parse('http://$baseUrl:8000/users/me');
    final accessToken = await storage.read(key: 'accesstoken');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return User.fromMap(userJson);
    } else {
      throw Exception("Failed to fetch user data: ${response.body}");
    }
  }

  Future<void> logoutUser() async {
    await storage.delete(key: 'accesstoken');
  }

  Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('http://$baseUrl:8000/users/change-password/');
    final accessToken = await storage.read(key: 'accesstoken');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      debugPrint("Response: $responseBody");
      return responseBody['message'];
    } else if (response.statusCode == 400) {
      final responseBody = json.decode(response.body);

      // เช็คว่าข้อความ error คืออะไร
      final errorMessage = responseBody['detail'] ?? 'Bad Request';

      // เช็คตามข้อความ error ที่ส่งกลับมา
      if (errorMessage == "Current password is incorrect") {
        throw Exception("Current password is incorrect. Please try again.");
      } else if (errorMessage ==
          "New password must be different from the current password") {
        throw Exception(
            "New password must be different from the current password.");
      } else {
        throw Exception(errorMessage); // สำหรับ error อื่นๆ
      }
    } else if (response.statusCode == 404) {
      throw Exception('User not found. Please check your login credentials.');
    } else {
      final responseBody = json.decode(response.body);
      final errorMessage =
          responseBody['detail'] ?? 'Failed to update password';
      throw Exception(errorMessage);
    }
  }
}
