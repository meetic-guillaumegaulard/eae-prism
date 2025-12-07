import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api/builder';

  /// Get file tree
  static Future<Map<String, dynamic>> getFileTree() async {
    final response = await http.get(Uri.parse('$baseUrl/files'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load file tree');
  }

  /// Read a JSON file
  static Future<Map<String, dynamic>> readFile(String path) async {
    final response = await http.get(Uri.parse('$baseUrl/files/$path'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to read file: $path');
  }

  /// Create or update a JSON file
  static Future<Map<String, dynamic>> saveFile(
    String path,
    Map<String, dynamic> content,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/files/$path'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(content),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to save file: $path');
  }

  /// Delete a JSON file
  static Future<Map<String, dynamic>> deleteFile(String path) async {
    final response = await http.delete(Uri.parse('$baseUrl/files/$path'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to delete file: $path');
  }

  /// Create a folder
  static Future<Map<String, dynamic>> createFolder(String path) async {
    final response = await http.post(Uri.parse('$baseUrl/folders/$path'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to create folder: $path');
  }

  /// Delete a folder
  static Future<Map<String, dynamic>> deleteFolder(String path) async {
    final response = await http.delete(Uri.parse('$baseUrl/folders/$path'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to delete folder: $path');
  }

  /// Get component specs
  static Future<Map<String, dynamic>> getComponentSpecs() async {
    final response = await http.get(Uri.parse('$baseUrl/component-specs'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load component specs');
  }

  /// Get graph data for a folder
  static Future<Map<String, dynamic>> getFolderGraph(String path) async {
    final response = await http.get(Uri.parse('$baseUrl/graph/$path'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load folder graph: $path');
  }
}
