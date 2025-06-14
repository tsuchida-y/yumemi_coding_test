import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  /// PopupMenuItem を構築するためのヘルパーメソッド
  PopupMenuItem<String> _buildMenuItem(String value, String text, bool showCheckmark) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          // showCheckmark が true の場合のみチェックアイコンを表示
          showCheckmark
              ? const Icon(Icons.check, size: 20) // true の場合
              : const SizedBox.shrink(), // false の場合 (何も表示しないウィジェット)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.sort),
      onSelected: (String userSelectedOption) {
        if (userSelectedOption == 'ascending' ||
            userSelectedOption == 'descending') {
          // 昇順/降順が選択された場合
          onSortSelected(currentSortOption, userSelectedOption == 'ascending');
        } else {
          // ソートキー (stars, forks) が選択された場合
          onSortSelected(userSelectedOption, isSortAscending);
        }
      },
      
      // ヘルパーメソッドを使って itemBuilder を簡潔にする
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildMenuItem('stars', AppLocalizations.of(context)!.sort_by_stars, currentSortOption == 'stars'),
        _buildMenuItem('forks', AppLocalizations.of(context)!.sort_by_forks, currentSortOption == 'forks'),
        const PopupMenuDivider(), // 区切り線
        _buildMenuItem('ascending', AppLocalizations.of(context)!.sort_ascending, isSortAscending),
        _buildMenuItem('descending', AppLocalizations.of(context)!.sort_descending, !isSortAscending),
      ],
    );
  }
}
