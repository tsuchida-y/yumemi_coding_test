import 'package:flutter/material.dart';

/// 検索結果が空の場合に表示するウィジェット
class EmptyResultWidget extends StatelessWidget {
  const EmptyResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/not_found.png',
            width: 300,
            height: 300,
          ),
          Text(
            "該当するリポジトリが見つかりませんでした。\n"
            "別のキーワードで試してみてください！",
            style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyLarge?.color
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
