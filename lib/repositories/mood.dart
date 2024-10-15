import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:moody/blocs/blocs.dart';

class MoodRepository {
  final storage = const FlutterSecureStorage();
  final String baseUrl;

  //AuthRepository({this.baseUrl = '127.0.0.1'}); // iOS Simulator
  MoodRepository({this.baseUrl = '10.0.2.2'}); // Android Simulator

  Future<String> addMood({
    required String moodType,
    required String description,
    required int userId,
  }) async {
    final url = Uri.parse('http://$baseUrl:8000/moods');
    final accessToken = await storage.read(key: 'accesstoken');

    if (accessToken == null) {
      throw Exception('No access token found');
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'mood_type': moodType, // Mood type (e.g., happy, sad)
        'description': description, // Additional info about the mood
        'user_id':
            userId, // User ID from secure storage or another source // Set the mood_id if necessary, or the server can auto-generate
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message']; // Return success message from API response
    } else {
      throw Exception('Failed to add mood');
    }
  }
}
