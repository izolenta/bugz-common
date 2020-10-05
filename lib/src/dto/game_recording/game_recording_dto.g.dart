// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_recording_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRecordingDto _$GameRecordingDtoFromJson(Map<String, dynamic> json) {
  return GameRecordingDto(
    (json['colorToTeam'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    (json['teamToRating'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    (json['steps'] as List)
        ?.map((e) =>
            e == null ? null : GameStepDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['winnerId'] as String,
  );
}

Map<String, dynamic> _$GameRecordingDtoToJson(GameRecordingDto instance) =>
    <String, dynamic>{
      'colorToTeam':
          instance.colorToTeam?.map((k, e) => MapEntry(k.toString(), e)),
      'teamToRating': instance.teamToRating,
      'steps': instance.steps?.map((e) => e?.toJson())?.toList(),
      'winnerId': instance.winnerId,
    };
