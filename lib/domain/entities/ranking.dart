enum Ranking {
  simple,
  stars
}

extension RankingJsonExtension on Ranking {
  String toJson() {
    switch (this) {
      case Ranking.simple:
        return 'simple';
      case Ranking.stars:
        return 'stars';
      default:
        throw FormatException('Invalid ranking value: $this');
    }
  }

  static Ranking fromJson(String json) {
    switch (json) {
      case 'simple':
        return Ranking.simple;
      case 'stars':
        return Ranking.stars;
      default:
        throw FormatException('Invalid ranking value: $json');
    }
  }
}