import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:yumemi_coding_test/utils/repository_sorter.dart';
import 'package:yumemi_coding_test/services/github_api_service.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/search/search_controls.dart';
import 'package:yumemi_coding_test/widgets/search/search_result_view.dart';
import 'package:yumemi_coding_test/widgets/theme/theme_selection_bottom_sheet.dart';

/// リポジトリ検索画面の状態を管理するクラス。
/// ユーザー入力、検索結果リスト、ソート状態の保持、API呼び出し、UI更新を行う。
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _userInput = TextEditingController();
  List<Repository> _repositoryList = [];
  final _isSortAscending = false;
  final _currentSortOption = 'stars';
  final gitHubApiService = GitHubApiService();

  /// リポジトリの検索を実行するメソッド
  void _searchRepositories() async {
    final repositoryName = _userInput.text;
    if (repositoryName.isNotEmpty) {
      final fetchedRepositories =
          await gitHubApiService.searchRepositories(repositoryName);
      setState(() {
        _repositoryList = fetchedRepositories;
      });
    }
  }

  /// ユーザが指定したソート条件を適用するメソッド
  void _sortRepositories(String sortOption, bool isSortAscending) {
    setState(() {
      
      RepositorySorter.sortRepositories(
          _repositoryList, sortOption, isSortAscending);
    });
  }

  /// テーマ選択用のボトムシートを表示するメソッド
  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const ThemeSelectionBottomSheet();
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceOrientation = MediaQuery.of(context).orientation;

    const double sideMargin = 40.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.app_title),
        actions: [
          Padding(

            // 横向きの場合、右側にマージンを追加
            padding: EdgeInsets.only(
              right: deviceOrientation == Orientation.landscape ? 40.0 : 0,
            ),

            child: IconButton(
              icon: const Icon(Icons.settings),
              tooltip: AppLocalizations.of(context)!.theme_tooltip,
              onPressed: () {
                _showThemeBottomSheet(context);
              },
            ),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final portraitOrientation = orientation == Orientation.portrait;
          final landscapeMaxWidth = deviceWidth - (sideMargin * 2);

          return Center(
            child: Container(

              //画面の向きが横なら、左右のマージンを考慮して最大幅を設定
              constraints: portraitOrientation
                  ? null
                  : BoxConstraints(maxWidth: landscapeMaxWidth),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    // 検索入力、ボタン、ソートを含むコントロール部分
                    SearchControls(
                      userInputController: _userInput,
                      onSearchPressed: _searchRepositories,
                      onSortSelected: _sortRepositories,
                      isSortAscending: _isSortAscending,
                      currentSortOption: _currentSortOption,
                      portraitOrientation: portraitOrientation,
                    ),
                    const SizedBox(height: 16),

                    // 検索結果リストまたはメッセージを表示
                    Expanded(
                      child: SearchResultView(repositoryList: _repositoryList),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///メモリリークや不要な処理の継続を防ぐ
  @override
  void dispose() {
    _userInput.dispose();
    super.dispose();
  }
}