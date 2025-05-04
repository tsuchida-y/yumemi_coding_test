import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:yumemi_coding_test/providers/theme_provider.dart';
import 'package:yumemi_coding_test/utils/themes.dart';
import 'package:yumemi_coding_test/screens/search_screen.dart';

/// アプリのエントリーポイント。
/// MaterialAppを構築し、テーマ設定やホーム画面としてSearchScreenを指定。

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(

          //アプリのタイトルを設定
          onGenerateTitle: (context) => AppLocalizations.of(context)!.app_title,

          //アプリの対応言語を設定
          supportedLocales:AppLocalizations.supportedLocales,

          // アプリ固有の文字列とFlutterウィジェットの標準文字列をロードするためのデリゲート
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          //システムで選択された言語がアプリ内でサポートされていたら、その言語を使用
          //サポートされていない場合は、デフォルトの言語（英語）を使用
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale?.languageCode) {
                return locale;
              }
            }
            return const Locale('en');
          },
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: SearchScreen(),
        );
      },
    );
  }
}
