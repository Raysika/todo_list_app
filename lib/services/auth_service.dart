import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String url =
      "https://acs314flutter.xyz/ray_students/login.php"; // Replace with your server URL

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.get(Uri.parse(
        'https://acs314flutter.xyz/ray_students/login.php?email=$email&password=$password'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
