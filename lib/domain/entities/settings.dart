import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/entities/ranking.dart';
import 'package:dog_sports_diary/domain/entities/theme.dart';

class Settings implements Entity{
  final int id;
  final Ranking ranking;
  final Theme theme;
  final int? currentDogId;

  Settings({
    required this.id,
    required this.ranking,
    required this.theme,
    this.currentDogId
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      ranking: json['ranking'],
      theme: json['theme'],
      currentDogId: json['currentDogId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ranking': ranking,
      'theme': theme,
      'currentDogId': currentDogId
    };
  }
}