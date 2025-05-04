import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:yumemi_coding_test/utils/repository_sorter.dart';
import 'package:yumemi_coding_test/services/github_api_service.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/widgets/search/search_body_view.dart';
import 'package:yumemi_coding_test/widgets/search/search_controls.dart';
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
  bool _isLoading = false;
  String? _errorMessage;
  String? _apiErrorMessage;



  /// リポジトリの検索を実行するメソッド
  void _searchRepositories() async {
    final repositoryName = _userInput.text;

    // 検索語が空の場合は処理を中断
    if (repositoryName.isEmpty) {
      // 検索語が空の場合はSnackBarでメッセージを表示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.search_term_empty),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return; // 処理を中断
    }

    // 検索開始時に状態を更新
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _repositoryList = [];
    });

    //API でリポジトリ検索を試み、成功したら結果を表示し、
    //失敗したらエラーメッセージを設定して SnackBar でユーザーに通知する
    try {
      final fetchedRepositories = await gitHubApiService.searchRepositories(repositoryName);
      setState(() {
        _repositoryList = fetchedRepositories;
        _isLoading = false;
      });
      _sortRepositories(_currentSortOption, _isSortAscending);
    } catch (e) {
      // エラー発生時に状態を更新
      setState(() {
        _apiErrorMessage = AppLocalizations.of(context)!.fetch_error;
        _isLoading = false;
      });

      // エラーメッセージをSnackBarで表示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_apiErrorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                      child: SearchBodyView(
                        isLoading: _isLoading,
                        apiErrorMessage: _apiErrorMessage,
                        repositoryList: _repositoryList,
                      ),
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