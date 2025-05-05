import 'package:flutter/material.dart';

/// エラーメッセージを SnackBar で表示するためのユーティリティクラス。
class ErrorSnackbar {
  ErrorSnackbar._();

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    // 既存の SnackBar があれば隠す
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // 新しい SnackBar を表示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating, 
        duration: duration, 
      ),
    );
  }
}