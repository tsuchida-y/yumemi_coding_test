import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:yumemi_coding_test/models/repository.dart';

///GitHub API を利用してリポジトリを検索するためのクラス
class GitHubApiService {

  Future<List<Repository>> searchRepositories(String searchQuery) async {
    final String? baseUrl = dotenv.env['GITHUB_API_BASE_URL'];
    final response = await http.get(Uri.parse('$baseUrl?q=$searchQuery'));

    if (response.statusCode == 200) {

      // レスポンスから取得したJSONデータをリスト形式でデコード
      // 各リポジトリ情報をRepositoryオブジェクトに変換してリストとして返す
      final List<dynamic> repositoriesJson =json.decode(response.body)['items'];
      return repositoriesJson.map((repo) => Repository.fromJson(repo)).toList();

    } else {
      throw Exception('Failed to load repositories. Status code: ${response.statusCode}, Body: ${response.body}');
    }
  }
}
