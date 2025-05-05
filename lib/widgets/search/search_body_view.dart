import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/search/search_result_view.dart';

/// 検索画面のメインコンテンツエリア。
/// ローディング状態、APIエラー、検索結果リストの状態に応じて表示を切り替える。
class SearchBodyView extends StatelessWidget {
  final bool isLoading;
  final String? apiErrorMessage;
  final List<Repository> repositoryList;

  const SearchBodyView({
    super.key,
    required this.isLoading,
    required this.apiErrorMessage,
    required this.repositoryList,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // ローディング中の場合
      return const Center(child: CircularProgressIndicator());
    } else if (apiErrorMessage != null) {
      // APIエラーが発生した場合
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            apiErrorMessage!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      // 正常時（結果表示）
      // SearchResultView は内部でリストが空の場合の表示もハンドリングする
      return SearchResultView(repositoryList: repositoryList);
    }
  }
}