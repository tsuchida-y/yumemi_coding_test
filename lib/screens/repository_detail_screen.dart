import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/models/repository.dart';

/// リポジトリの詳細情報を表示する画面を構築するクラス
/// リポジトリ名、オーナーのアバター画像、使用言語、スター数などを表示する
class RepositoryDetailScreen extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    const double sideMargin = 30.0;

    // 表示するテキストと値をリストで管理
    final repositoryDetails = [
      {"label": "言語",         "value": repository.language},
      {"label": "スター数",      "value": repository.stars.toString()},
      {"label": "ウォッチャー数", "value": repository.watchers.toString()},
      {"label": "フォーク数",    "value": repository.forks.toString()},
      {"label": "未解決の課題",   "value": repository.openIssues.toString()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(repository.name)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final landscapeMaxWidth = deviceWidth - (sideMargin * 2);

          return Center(
            child: Container(
              //画面の向きが横なら、左右のマージンを考慮して最大幅を設定
              constraints: orientation == Orientation.portrait
                  ? null
                  : BoxConstraints(maxWidth: landscapeMaxWidth),

              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:NetworkImage(repository.ownerAvatarUrl),
                      ),

                      // repositoryDetailsリストの各項目を「詳細行 + 下部スペース」の Column に変換して展開
                      for (var detailItem in repositoryDetails)
                        Column(
                          children: [
                            _buildDetailRow(
                                detailItem["label"]!, detailItem["value"]!),
                            const SizedBox(height: 10),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

            ),
          );
        },
      ),
    );
  }

  /// テキストと値を揃えて表示する行を構築するメソッド
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
