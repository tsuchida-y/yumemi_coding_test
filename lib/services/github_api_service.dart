import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yumemi_codingtest/models/repository.dart';

class GitHubApiService {
  final String _baseUrl = "https://api.github.com/search/repositories";

  Future<List<Repository>> searchRepositories(String keyword) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$keyword'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['items'];
      return data.map((repo) => Repository.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}