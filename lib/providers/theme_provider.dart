import 'package:flutter/material.dart';

/// アプリのテーマモード (ライト/ダーク) を管理するクラス。
/// 状態変更をリスナーに通知し、UIの動的なテーマ切り替えを実現する。
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  /// テーマモードを設定するためのメソッド
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners(); // 状態の変更を通知
    }
  }

  /// ライト/ダークを簡単に切り替えるためのヘルパーメソッド
  void toggleTheme(bool isDark) {
     setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }


  /// 現在のテーマモードがダークモードかどうかを判定するためのゲッターメソッド
  /// ユーザーが明示的にダークモードを選択したかを知りたい場合に使用
  // bool get isDarkMode {
  //   return _themeMode == ThemeMode.dark;
  // }
}