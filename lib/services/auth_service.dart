import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<bool> register({
    required String username,
    required String password,
    required String email,
    required String phoneNumber,
    required String address,
  }) async {
    final url = Uri.parse('$baseUrl/register/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }
}
