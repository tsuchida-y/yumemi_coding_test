import 'package:flutter/material.dart';
import 'package:yumemi_codingtest/models/repository.dart';

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
