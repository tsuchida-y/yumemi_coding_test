import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/detail/detail_row.dart';

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
    {"label": AppLocalizations.of(context)!.language,    "value": repository.language},
    {"label": AppLocalizations.of(context)!.stars,       "value": repository.stars.toString()},
    {"label": AppLocalizations.of(context)!.watchers,    "value": repository.watchers.toString()},
    {"label": AppLocalizations.of(context)!.forks,       "value": repository.forks.toString()},
    {"label": AppLocalizations.of(context)!.open_issues,  "value": repository.openIssues.toString()},
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

                      // 各詳細行を DetailRow ウィジェットで表示
                      for (var detail in repositoryDetails) ...[
                        DetailRow(
                          label: detail["label"]!,
                          value: detail["value"]!,
                        ),
                        const SizedBox(height: 10),
                      ],
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
}
