import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yumemi_coding_test/models/repository.dart';

///GitHub API を利用してリポジトリを検索するためのクラス
class GitHubApiService {
  final String _baseUrl = "https://api.github.com/search/repositories";

  Future<List<Repository>> searchRepositories(String searchQuery) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$searchQuery'));

    if (response.statusCode == 200) {

      // レスポンスから取得したJSONデータをリスト形式でデコード
      // 各リポジトリ情報をRepositoryオブジェクトに変換してリストとして返す
      final List<dynamic> repositoriesJson =json.decode(response.body)['items'];
      return repositoriesJson.map((repo) => Repository.fromJson(repo)).toList();

    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
