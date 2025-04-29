import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/services/github_api_service.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/repository_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Repository> _repositories = [];

  void _searchRepositories() async {
    final apiService = GitHubApiService();
    final keyword = _controller.text;
    if (keyword.isNotEmpty) {
      final results = await apiService.searchRepositories(keyword);
      setState(() {
        _repositories = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GitHub Repository Search")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Search Repositories"),
            ),
            ElevatedButton(
              onPressed: _searchRepositories,
              child: Text("Search"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _repositories.length,
                itemBuilder: (context, index) {
                  return RepositoryCard(repository: _repositories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
