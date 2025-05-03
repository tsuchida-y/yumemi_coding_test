import 'package:flutter/material.dart';

typedef SortCallback = void Function(String sortOption, bool isSortAscending);


/// ソートオプションを選択するためのドロップダウンメニューを提供するウィジェット。
/// ユーザーがソート条件や昇順/降順を選択できる。
class SortDropdown extends StatelessWidget {
  final SortCallback onSortSelected;
  final bool isSortAscending;
  final String currentSortOption;

  const SortDropdown({
    super.key,
    required this.onSortSelected,
    required this.isSortAscending,
    required this.currentSortOption,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.sort),

      // ユーザーが昇順/降順を選択した場合とスター数/フォーク数を選択した場合で処理を分ける
      onSelected: (String userSelectedOption) {
        if (userSelectedOption == 'ascending' || userSelectedOption == 'descending') {
          onSortSelected(currentSortOption, userSelectedOption == 'ascending');
        } else {
          onSortSelected(userSelectedOption, isSortAscending);
        }
      },

      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'stars',
          child: Text("スター数でソート"),
        ),
        PopupMenuItem(
          value: 'forks',
          child: Text("フォーク数でソート"),
        ),
        PopupMenuDivider(), // 区切り線
        PopupMenuItem(
          value: 'ascending',
          child: Text("昇順"),
        ),
        PopupMenuItem(
          value: 'descending',
          child: Text("降順"),
        ),
      ],
    );
  }
}