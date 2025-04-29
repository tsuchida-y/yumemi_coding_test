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

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      ownerAvatarUrl: json['owner']['avatar_url'],
      language: json['language'] ?? 'N/A',
      stars: json['stargazers_count'],
      watchers: json['watchers_count'],
      forks: json['forks_count'],
      openIssues: json['open_issues_count'],
    );
  }
}
