import 'package:dog_sports_diary/domain/abstractions/entity.dart';
import 'package:dog_sports_diary/domain/value_objects/ranking.dart';
import 'package:dog_sports_diary/domain/value_objects/theme.dart';

class Settings implements Entity{
  @override
  int? id;
  final Ranking ranking;
  final Theme theme;
  final int? currentDogId;

  Settings({
    this.id,
    required this.ranking,
    required this.theme,
    this.currentDogId
  });

  Settings copyWith({
    int? id,
    Ranking? ranking,
    Theme? theme,
    int? currentDogId
  }) {
    return Settings(
      id: id ?? this.id,
      ranking: ranking ?? this.ranking,
      theme: theme ?? this.theme,
      currentDogId: currentDogId ?? this.currentDogId
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      ranking: RankingJsonExtension.fromJson(json['ranking']),
      theme: ThemeJsonExtension.fromJson(json['theme']),
      currentDogId: json['currentDogId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ranking': ranking.toJson(),
      'theme': theme.toJson(),
      'currentDogId': currentDogId
    };
  }

  @override
  void setId(){
    id = hashCode;
  }

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other){
    return other is Settings
        && other.id == id;
  }
}