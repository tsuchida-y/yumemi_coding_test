import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yumemi_coding_test/widgets/search/sort_dropdown.dart';

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
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.search_hint),
          onSubmitted: (_) => onSearchPressed(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            ElevatedButton(
              onPressed: onSearchPressed,
              child: Text(AppLocalizations.of(context)!.search_button),
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