import 'package:flutter/material.dart';

/// 検索結果が空の場合に表示するウィジェット

class EmptyResultWidget extends StatelessWidget {
  const EmptyResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/notfound.png',
            width: 300,
            height: 300,
          ),
          Text(
            "該当するリポジトリが見つかりませんでした。\n"
            "別のキーワードで試してみてください！",
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}