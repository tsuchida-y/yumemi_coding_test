import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:yumemi_coding_test/providers/theme_provider.dart';

/// テーマオプションのデータを定義するクラス
class _ThemeOption {
  final ThemeMode mode;
  final IconData icon;
  final String labelText;

  const _ThemeOption(
      {required this.mode, required this.icon, required this.labelText});
}

/// アプリのテーマ（ライト/ダーク）を選択するためのボトムシートウィジェット。
/// タップされたテーマを ThemeProvider に設定し、シートを閉じる。
class ThemeSelectionBottomSheet extends StatelessWidget {
  const ThemeSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

    //テーマ選択肢(ライト/ダーク)のリストを定義
    final themeOptions = [
      _ThemeOption(
        mode: ThemeMode.light,
        icon: Icons.brightness_5,
        labelText: AppLocalizations.of(context)!.theme_light,
      ),
      _ThemeOption(
        mode: ThemeMode.dark,
        icon: Icons.dark_mode,
        labelText: AppLocalizations.of(context)!.theme_dark,
      ),
    ];
    
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: themeOptions.map((themeOption) {
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
