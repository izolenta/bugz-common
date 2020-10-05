// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_step_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameStepDto _$GameStepDtoFromJson(Map<String, dynamic> json) {
  return GameStepDto(
    (json['bugs'] as List)
        ?.map((e) =>
            e == null ? null : GameBugDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['food'] as List)
        ?.map((e) =>
            e == null ? null : PointDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['teamToLife'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$GameStepDtoToJson(GameStepDto instance) =>
    <String, dynamic>{
      'bugs': instance.bugs,
      'food': instance.food,
      'teamToLife': instance.teamToLife,
    };
