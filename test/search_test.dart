import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:yumemi_coding_test/providers/theme_provider.dart';
import 'package:yumemi_coding_test/screens/search_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yumemi_coding_test/services/github_api_service.dart';
import 'package:yumemi_coding_test/widgets/common/repository_card.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  // テスト可能なウィジェットを作成するヘルパー関数 (実際のサービスを注入)
  Widget createTestableWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<GitHubApiService>(create: (_) => GitHubApiService()),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ja'),
        home: child,
      ),
    );
  }

  // --- SearchScreen のテストケース ---
  group('SearchScreen Tests', () { // テストをグループ化すると分かりやすい
    testWidgets('displays initial UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(SearchScreen()));

      // AppLocalizations を取得するために context が必要
      final BuildContext context = tester.element(find.byType(SearchScreen));
      final l10n = AppLocalizations.of(context)!;

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, l10n.search_button), findsOneWidget);
      expect(find.byIcon(Icons.sort), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Shows SnackBar when search term is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(SearchScreen()));

      final BuildContext context = tester.element(find.byType(SearchScreen));
      final l10n = AppLocalizations.of(context)!;

      final searchButton = find.widgetWithText(ElevatedButton, l10n.search_button);
      expect(searchButton, findsOneWidget);

      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      expect(find.widgetWithText(SnackBar, l10n.search_term_empty), findsOneWidget);
    });

    // API呼び出しを伴うテスト (ネットワーク依存)
    testWidgets('Shows loading indicator and potentially results on search', (WidgetTester tester) async {
      final testQuery = 'flutter';
      await tester.pumpWidget(createTestableWidget(SearchScreen()));
      final BuildContext context = tester.element(find.byType(SearchScreen));
      final l10n = AppLocalizations.of(context)!;

      await tester.enterText(find.byType(TextField), testQuery);
      await tester.tap(find.widgetWithText(ElevatedButton, l10n.search_button));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      expect(find.byType(CircularProgressIndicator), findsNothing);


      final errorFinder = find.widgetWithText(Center, l10n.fetch_error);
      final emptyFinder = find.widgetWithText(Center, l10n.no_results); 

      if (tester.any(errorFinder)) {
        expect(find.widgetWithText(SnackBar, l10n.fetch_error), findsOneWidget);
      } else if (tester.any(emptyFinder)) {
        expect(find.byType(ListView), findsNothing);
      } else {
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(RepositoryCard), findsWidgets);
      }
    }, timeout: const Timeout(Duration(seconds: 20)));

    // API呼び出しを伴うテスト (ネットワーク依存)
    testWidgets('Shows error message on API failure (simulated by bad query)', (WidgetTester tester) async {
      final testQuery = 'a_very_unlikely_repository_name_string_xyz';
      await tester.pumpWidget(createTestableWidget(SearchScreen()));

      // AppLocalizations を取得
      final BuildContext context = tester.element(find.byType(SearchScreen));
      final l10n = AppLocalizations.of(context)!;

      await tester.enterText(find.byType(TextField), testQuery);
      await tester.tap(find.widgetWithText(ElevatedButton, l10n.search_button));
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 10));
      expect(find.byType(CircularProgressIndicator), findsNothing);

      final errorFinder = find.widgetWithText(Center, 'リポジトリの取得に失敗しました');
      final emptyFinder = find.widgetWithText(Center, '検索結果はありません');
      expect(tester.any(errorFinder) || tester.any(emptyFinder), isTrue);
    }, timeout: const Timeout(Duration(seconds: 20)));

    // API呼び出しを伴うテスト (ネットワーク依存)
    testWidgets('Sort dropdown selection updates sort state (basic check)', (WidgetTester tester) async {
      final testQuery = 'flutter';
      await tester.pumpWidget(createTestableWidget(SearchScreen()));

      // AppLocalizations を取得
      final BuildContext context = tester.element(find.byType(SearchScreen));
      final l10n = AppLocalizations.of(context)!;

      await tester.enterText(find.byType(TextField), testQuery);
      await tester.tap(find.widgetWithText(ElevatedButton, l10n.search_button));
      await tester.pumpAndSettle(const Duration(seconds: 10));

      if (!tester.any(find.byType(ListView))) {
        print('Skipping sort test because no results were found.');
        return;
      }

      // ソートキー選択
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      final forksMenuText = l10n.forks;
      await tester.tap(find.text(forksMenuText));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      expect(
        find.ancestor(
          of: find.byIcon(Icons.check),
          matching: find.widgetWithText(PopupMenuItem<String>, forksMenuText)
        ),
        findsOneWidget
      );
      await tester.tapAt(Offset.zero); // メニューを閉じる
      await tester.pumpAndSettle();

      // --- ソート順の選択テスト ---
      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      // メニュー項目も l10n を使用
      final ascendingMenuText = l10n.sort_ascending; // '昇順' に対応するキー
      await tester.tap(find.text(ascendingMenuText));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();
      expect(
        find.ancestor(
          of: find.byIcon(Icons.check),
          matching: find.widgetWithText(PopupMenuItem<String>, ascendingMenuText)
        ),
        findsOneWidget
      );
      await tester.tapAt(Offset.zero); 
      await tester.pumpAndSettle();

    }, timeout: const Timeout(Duration(seconds: 30)));
  }); 
}