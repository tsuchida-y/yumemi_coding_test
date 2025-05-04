import 'package:flutter/material.dart';

import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/empty_result.dart';
import 'package:yumemi_coding_test/widgets/repository_card.dart';

/// 検索結果リストまたは「結果なし」メッセージを表示するウィジェット。
class SearchResultView extends StatelessWidget {
  final List<Repository> repositoryList;

  const SearchResultView({
    super.key,
    required this.repositoryList,
  });

  @override
  Widget build(BuildContext context) {
    // リポジトリリストが空の場合、「結果なし」ウィジェットを表示
    if (repositoryList.isEmpty) {
      return const EmptyResultWidget();
    }

    // リストにデータがある場合、ListView でリポジトリカードを表示
    return ListView.builder(
      itemCount: repositoryList.length,
      itemBuilder: (context, index) {
        final currentRepository = repositoryList[index];
        return RepositoryCard(repository: currentRepository);
      },
    );
  }
}