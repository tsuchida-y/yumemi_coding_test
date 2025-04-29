import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/models/repository.dart';

/// リポジトリの詳細情報を表示する画面を構築するクラス
/// リポジトリ名、オーナーのアバター画像、使用言語、スター数などを表示する

class RepositoryDetailScreen extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    // 表示するラベルと値をリストで管理
    final repositoryDetails = [
      {"label": "言語", "value": repository.language},
      {"label": "スター数", "value": repository.stars.toString()},
      {"label": "ウォッチャー数", "value": repository.watchers.toString()},
      {"label": "フォーク数", "value": repository.forks.toString()},
      {"label": "未解決の課題", "value": repository.openIssues.toString()},
    ];

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
              SizedBox(height: 20),
              // リストを動的にウィジェットに変換
              ...repositoryDetails.map((detailItem) => Column(
                    children: [
                      _buildDetailRow(detailItem["label"]!, detailItem["value"]!),
                      SizedBox(height: 10),
                    ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  /// ラベルと値を揃えて表示する行を構築するメソッド
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
