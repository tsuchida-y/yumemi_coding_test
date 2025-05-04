import 'package:flutter/material.dart';
import 'package:yumemi_coding_test/widgets/sort_option.dart';

/// 検索入力フィールド、検索ボタン、ソートドロップダウンをまとめたウィジェット。
class SearchControls extends StatelessWidget {
  final TextEditingController userInputController;
  final VoidCallback onSearchPressed;
  final Function(String, bool) onSortSelected;
  final bool isSortAscending;
  final String currentSortOption;
  final bool portraitOrientation;

  const SearchControls({
    super.key,
    required this.userInputController,
    required this.onSearchPressed,
    required this.onSortSelected,
    required this.isSortAscending,
    required this.currentSortOption,
    required this.portraitOrientation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: userInputController,
          decoration: const InputDecoration(labelText: "リポジトリ名で検索"),
          onSubmitted: (_) => onSearchPressed(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            ElevatedButton(
              onPressed: onSearchPressed,
              child: const Text("検索"),
            ),
            const Spacer(flex: 2),
            SortDropdown(
              onSortSelected: onSortSelected,
              isSortAscending: isSortAscending,
              currentSortOption: currentSortOption,
            ),
          ],
        ),
      ],
    );
  }
}