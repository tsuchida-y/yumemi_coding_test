import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/screens/repository_detail_screen.dart';

class RepositoryCard extends StatelessWidget {
  final Repository repository;

  const RepositoryCard({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(repository.name),
        subtitle: Text(repository.language),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(repository.ownerAvatarUrl),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepositoryDetailScreen(repository: repository),
            ),
          );
        },
      ),
    );
  }
}
