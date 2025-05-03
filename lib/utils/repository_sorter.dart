import 'package:yumemi_coding_test/models/repository.dart';

/// リポジトリのリストをソートするためのクラス。
/// 指定された条件（スター数、フォーク数など）と順序（昇順/降順）に基づいてソートする。
class RepositorySorter {
  static void sortRepositories(
      List<Repository> repositories, String sortOption, bool isAscending) {
    repositories.sort((a, b) {
      int comparison;
      switch (sortOption) {
        case 'stars':
          comparison = a.stars.compareTo(b.stars);
          break;
        case 'forks':
          comparison = a.forks.compareTo(b.forks);
          break;
        default:
          comparison = 0;
      }
      return isAscending ? comparison : -comparison;
    });
  }
}