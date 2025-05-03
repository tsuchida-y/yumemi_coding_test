import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:yumemi_coding_test/providers/theme_provider.dart';
import 'package:yumemi_coding_test/utils/themes.dart';
import 'package:yumemi_coding_test/screens/search_screen.dart';

/// アプリのエントリーポイント。
/// MaterialAppを構築し、テーマ設定やホーム画面としてSearchScreenを指定。

Future<void> main() async {
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
          title: 'GitHub Repository Search',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode, // Consumerから受け取った themeProvider を使用
          home: SearchScreen(),
        );
      },
    );
  }
}
