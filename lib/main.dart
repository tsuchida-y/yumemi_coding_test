import 'package:flutter/material.dart';
import 'screens/search_screen.dart';

/// アプリのエントリーポイント。
/// MaterialAppを構築し、テーマ設定やホーム画面としてSearchScreenを指定。

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repository Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: SearchScreen(),
    );
  }
}
