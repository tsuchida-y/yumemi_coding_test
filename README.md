# GitHubリポジトリ検索アプリ

## 概要
このアプリは、GitHub API を利用してリポジトリを検索し、検索結果を一覧表示する Flutter アプリです。
ユーザーは検索キーワードを入力することで、GitHub 上のリポジトリを簡単に検索できます。

## 背景・目的
- 株式会社ゆめみ様のコーディングテスト課題として作成しました。
- GitHub API を活用したアプリケーションの設計・実装能力をアピールするため。
- Flutter を使用したモダンな UI/UX の実現を目指しました。

## 主な機能
- **リポジトリ検索**: キーワードを入力して GitHub 上のリポジトリを検索。
- **検索結果の表示**: リポジトリ名、スター数、言語、フォーク数、ウォッチャー数などを一覧表示。
- **詳細画面**: リポジトリの詳細情報（オーナーのアバター画像、スター数、言語など）を表示。
- **ソート機能**: 検索結果をスター数・フォーク数で昇順・降順にソート。

## 工夫した点

-   **コードの可読性と保守性の向上**:
    *   **責務の明確化**: 機能や役割（モデル、スクリーン、サービス、ウィジェットなど）に基づいてファイルを分割しました。
    *   **命名規則**: 変数名やメソッド名を分かりやすくし、コードの意図を理解しやすくしました。
    *   **コード整形**: リストなどの要素を縦に揃えることで、各要素の違いを視覚的に分かりやすくしました。

-   **ユーザー体験 (UX) の向上**:
    *   **空の検索結果**: 検索結果がない場合に専用の画像とメッセージを表示し、ユーザーが状況を直感的に把握できるようにしました。
    *   **状態の可視化**: 現在選択されているソート条件やテーマモードにチェックマークを表示し、現在の設定を分かりやすくしました。

-   **開発プロセスの効率化**:
    *   **コミットメッセージ規約**: Conventional Commits のプレフィックス（例: `feat:`, `fix:`）を導入し、各コミットの変更内容を容易に識別できるようにしました。


## 使用技術
- **言語**: Dart
- **フレームワーク**: Flutter
- **API**: GitHub REST API
- **パッケージ**:
  - `http`: HTTP リクエストの送信
  - `provider`: 状態管理
  - `flutter_dotenv`: 環境変数管理 (.env ファイル)
  - `flutter_test`: テストフレームワーク

## ファイル構成
```
lib/
├── main.dart
├── models/
│   └── repository.dart
├── providers/
│   └── theme_provider.dart
├── screens/
│   ├── repository_detail_screen.dart
│   └── search_screen.dart
├── services/
│   └── github_api_service.dart
├── utils/
│   ├── repository_sorter.dart
│   └── themes.dart
└── widgets/
    ├── empty_result.dart
    ├── repository_card.dart
    ├── sort_option.dart
    └── theme_selection_bottom_sheet.dart
```

## 開発ルール

### コミットメッセージのルール
コミットメッセージには以下のPrefixを使用してください：

- **feat**: 新しい機能の追加
- **fix**: バグ修正
- **docs**: ドキュメントのみの変更
- **style**: コードの意味に影響を与えない変更（空白、フォーマット、セミコロンの追加など）
- **refactor**: バグ修正や機能追加ではないコードの変更
- **perf**: パフォーマンス向上、可読性向上を目的とした変更
- **test**: テストの追加や既存テストの修正
- **chore**: ビルドプロセスや補助ツール、ライブラリ関連の変更

以下を参考にしました：
[僕が考える最強のコミットメッセージの書き方](https://qiita.com/konatsu_p/items/dfe199ebe3a7d2010b3e)

## 使用方法
1. このリポジトリをクローンします。
   ```bash
   git clone https://github.com/your-username/github-repository-search.git
2. 必要なパッケージをインストールします。
    ```bash
    flutter pub get
3. アプリを実行します。
    ```bash
    flutter run
## テスト
- **ユニットテスト**: `github_api_service.dart` の API 呼び出しロジックをテスト。
- **UIテスト**: 検索画面と詳細画面の動作確認。
- **テストの実行方法**:
    ```bash
    flutter test
## 今後の改善点
- **多言語対応**:日本語と英語の切り替えをサポートする。
- **アニメーション**:検索結果の表示にアニメーションを追加する。
- **キャッシュ機能**:検索結果をローカルにキャッシュしてオフラインでも表示可能にする。
- **UI/UX**: ダークモード対応、エラーメッセージ表示、レスポンシブデザインを実装。

## アピールポイント
- **レビューのしやすさ**:適切なコメントとファイル構成でコードを整理
- **Git運用**:適切なコミット粒度とブランチ運用を実施

## クレジット（画像著作権表記）

このアプリで使用しているイラストは以下の素材を利用しています：

- [Person looking through magnifying glass - pch.vector](https://jp.freepik.com/free-vector/person-looking-through-magnifying-glass-question-mark-hand-holding-magnifier-search-answer-flat-vector-illustration-information-concept-banner-website-design-landing-web-page_27573146.htm)  
  著作者：pch.vector／出典：Freepik