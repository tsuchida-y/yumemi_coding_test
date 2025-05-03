import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/models/repository_sorter.dart';
import 'package:yumemi_coding_test/services/github_api_service.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/empty_result.dart';
import 'package:yumemi_coding_test/widgets/repository_card.dart';
import 'package:yumemi_coding_test/widgets/sort_option.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _userInput = TextEditingController();
  List<Repository> _repositoryList = [];
  final _isSortAscending = true;
  final _currentSortOption = 'stars';


  /// リポジトリの検索を実行するメソッド
  void _searchRepositories() async {
    final gitHubApiService = GitHubApiService();
    final repositoryName = _userInput.text;
    if (repositoryName.isNotEmpty) {
      final fetchedRepositories =
          await gitHubApiService.searchRepositories(repositoryName);
      setState(() {
        _repositoryList = fetchedRepositories;
      });
    }
  }


  /// ユーザが指定したソート条件を適用するメソッド
  void _sortRepositories(String sortOption, bool isSortAscending) {
    setState(() {
      RepositorySorter.sortRepositories(
          _repositoryList, sortOption, isSortAscending);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GitHub リポジトリ検索")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _userInput,
              decoration: InputDecoration(labelText: "リポジトリ名で検索"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 3),
                ElevatedButton(
                  onPressed: _searchRepositories,
                  child: Text("検索"),
                ),
                Spacer(flex: 2),
                SortDropdown(
                  onSortSelected: (String sortOption, bool isSortAscending) {
                    _sortRepositories(sortOption, isSortAscending);
                  },
                  isSortAscending: _isSortAscending,
                  currentSortOption: _currentSortOption,
                ),
              ],
            ),
            Expanded(
              child: _repositoryList.isEmpty
                  ? const EmptyResultWidget()
                  : ListView.builder(
                      itemCount: _repositoryList.length,
                      itemBuilder: (context, index) {
                        return RepositoryCard(
                            repository: _repositoryList[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
