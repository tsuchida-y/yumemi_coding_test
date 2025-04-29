import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/models/repository.dart';

/// リポジトリの詳細情報を表示する画面を構築するクラス
/// リポジトリ名、オーナーのアバター画像、使用言語、スター数などを表示する

class RepositoryDetailScreen extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repository.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(repository.ownerAvatarUrl),
            ),
            SizedBox(height: 20),
            Text("Language: ${repository.language}"),
            Text("Stars: ${repository.stars}"),
            Text("Watchers: ${repository.watchers}"),
            Text("Forks: ${repository.forks}"),
            Text("Open Issues: ${repository.openIssues}"),
          ],
        ),
      ),
    );
  }
}
