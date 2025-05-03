
///GitHub API のレスポンスから取得したリポジトリ情報を表現するためのモデルクラス
class Repository {
  final String name;
  final String ownerAvatarUrl;
  final String language;
  final int stars;
  final int watchers;
  final int forks;
  final int openIssues;

  Repository({
    required this.name,
    required this.ownerAvatarUrl,
    required this.language,
    required this.stars,
    required this.watchers,
    required this.forks,
    required this.openIssues,
  });

  /// JSONデータをRepositoryオブジェクトに変換するファクトリメソッド。
  factory Repository.fromJson(Map<String, dynamic> repositoryJson) {
    return Repository(
      name:           repositoryJson['name'],
      ownerAvatarUrl: repositoryJson['owner']['avatar_url'],
      language:       repositoryJson['language'] ?? 'N/A',
      stars:          repositoryJson['stargazers_count'],
      watchers:       repositoryJson['watchers_count'],
      forks:          repositoryJson['forks_count'],
      openIssues:     repositoryJson['open_issues_count'],
    );
  }
}
