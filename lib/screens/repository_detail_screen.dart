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
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(repository.ownerAvatarUrl),
              ),
              SizedBox(height: 10),
              _buildDetailRow("言語", repository.language),
              SizedBox(height: 10),
              _buildDetailRow("スター数", repository.stars.toString()),
              SizedBox(height: 10),
              _buildDetailRow("ウォッチャー数", repository.watchers.toString()),
              SizedBox(height: 10),
              _buildDetailRow("フォーク数", repository.forks.toString()),
              SizedBox(height: 10),
              _buildDetailRow("未解決の課題", repository.openIssues.toString()),
            ],
          ),
        ),
      ),
    );
  }

  /// ラベルと値を揃えて表示する行を構築するヘルパーメソッド
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
