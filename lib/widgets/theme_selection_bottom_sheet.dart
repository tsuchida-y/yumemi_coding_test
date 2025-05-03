import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

/// テーマオプションのデータを定義するクラス
class _ThemeOption {
  final ThemeMode mode;
  final IconData icon;
  final String labelText;

  const _ThemeOption({required this.mode, required this.icon, required this.labelText});
}

/// アプリのテーマ（ライト/ダーク）を選択するためのボトムシートウィジェット。
/// タップされたテーマを ThemeProvider に設定し、シートを閉じる。
class ThemeSelectionBottomSheet extends StatelessWidget {
  const ThemeSelectionBottomSheet({super.key});

  // テーマオプションのリスト
  static const List<_ThemeOption> _themeOptions = [
    _ThemeOption(mode: ThemeMode.light, icon: Icons.brightness_5, labelText: 'ライトテーマ'),
    _ThemeOption(mode: ThemeMode.dark,  icon: Icons.dark_mode,    labelText: 'ダークテーマ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _themeOptions.map((themeOption) {
                return ListTile(
                  leading: Icon(themeOption.icon),
                  title: Text(themeOption.labelText),

                  // 現在のテーマモードと一致する場合、末尾にチェックアイコンを表示
                  trailing: themeProvider.themeMode == themeOption.mode
                      ? const Icon(Icons.check)
                      : null,

                  onTap: () {
                    themeProvider.setThemeMode(themeOption.mode);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}