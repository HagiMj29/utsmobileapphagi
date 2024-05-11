import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AppConfig {
  static const String baseUrl = "http://192.168.1.8:8000/api";
  static const String baseStorage = 'http://192.168.1.8:8000/storage/';
}

class ApiServices {
  final String baseUrl;

  ApiServices({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }


  Future<Map<String, dynamic>> updateUser(int userId, String name, String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      body: {'name': name, 'email': email},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final Uri uri = Uri.parse('$baseUrl/register');
    final Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(uri, body: body);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Register: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> sejarawan(String name, String birthdate, String origin, String sex, String description, Uint8List? image) async {
    final Uri uri = Uri.parse('$baseUrl/sejarawan');

    // Buat request multipart
    var request = http.MultipartRequest('POST', uri);

    // Tambahkan data
    request.fields.addAll({
      'name': name,
      'birthdate': birthdate,
      'origin': origin,
      'sex': sex,
      'description': description,
    });

    // Tambahkan gambar jika ada
    if (image != null) {
      request.files.add(
        http.MultipartFile(
          'image',
          http.ByteStream.fromBytes(image),
          image.length,
          filename: 'image.jpg',
        ),
      );
    }

    // Kirim request
    var response = await request.send();

    // Handle response
    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to add Sejarawan Data: ${response.toString()}');
    }
  }


  Future<Map<String, dynamic>> updateSejarawan(int id, String name, String birthdate, String origin, String sex, String description, Uint8List? image) async {
    final Uri uri = Uri.parse('$baseUrl/sejarawans/$id/update');

    // Buat request multipart
    var request = http.MultipartRequest('POST', uri);

    // Tambahkan data
    request.fields.addAll({
      'name': name,
      'birthdate': birthdate,
      'origin': origin,
      'sex': sex,
      'description': description,
    });

    // Tambahkan gambar jika ada
    if (image != null) {
      request.files.add(
        http.MultipartFile(
          'image',
          http.ByteStream.fromBytes(image),
          image.length,
          filename: 'image.jpg',
        ),
      );
    }

    // Kirim request
    var response = await request.send();

    // Handle response
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to update Sejarawan Data: ${response.reasonPhrase}');
    }
  }









}