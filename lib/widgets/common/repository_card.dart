import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:yumemi_coding_test/models/repository.dart';
import 'package:yumemi_coding_test/screens/repository_detail_screen.dart';

/// GitHubリポジトリ情報を表示するカードウィジェットを構築するウィジェット
/// リポジトリ名、使用言語、オーナーのアバター画像を表示し、タップすると詳細画面に遷移する
class RepositoryCard extends StatelessWidget {
  final Repository repository;
  static const double _avatarSize = 40.0;

  const RepositoryCard({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(repository.name),
        subtitle: Text(repository.language.isNotEmpty ? repository.language : AppLocalizations.of(context)!.notAvailable),
        leading: CircleAvatar(
          child: ClipOval( // CircleAvatarの形にクリップ
            child: Image.network(
              repository.ownerAvatarUrl,
              fit: BoxFit.cover,
              width: _avatarSize,
              height: _avatarSize,

              // エラー時にプレースホルダーアイコンを表示
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: _avatarSize); // または他の適切なアイコン
              },

              // 画像のダウンロード状況が分かればプログレスバーを進め、
              // 分からなければ単にくるくる回るアニメーションを表示します
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },

            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RepositoryDetailScreen(repository: repository),
            ),
          );
        },
      ),
    );
  }
}
