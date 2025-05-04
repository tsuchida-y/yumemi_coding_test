import 'package:flutter/material.dart';

/// エラーメッセージを SnackBar で表示するためのユーティリティクラス。
class ErrorSnackbar {
  // プライベートコンストラクタでインスタンス化を防ぐ
  ErrorSnackbar._();

  /// エラーメッセージを含む SnackBar を表示する。
  ///
  /// [context] 表示する画面の BuildContext。
  /// [message] 表示するエラーメッセージ文字列。
  /// [duration] SnackBar の表示時間 (デフォルトは4秒)。
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    // 既存の SnackBar があれば隠す
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // 新しい SnackBar を表示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error, // テーマのエラー色を使用
        behavior: SnackBarBehavior.floating, // 少し浮いた表示 (任意)
        duration: duration,
        action: SnackBarAction( // 閉じるアクション (任意)
          label: '閉じる', // TODO: ローカライズするなら AppLocalizations を使う
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}