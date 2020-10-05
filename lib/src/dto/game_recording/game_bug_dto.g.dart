// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_bug_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameBugDto _$GameBugDtoFromJson(Map<String, dynamic> json) {
  return GameBugDto(
    json['coords'] == null
        ? null
        : PointDto.fromJson(json['coords'] as Map<String, dynamic>),
    json['direction'] as int,
    json['color'] as int,
  );
}

Map<String, dynamic> _$GameBugDtoToJson(GameBugDto instance) =>
    <String, dynamic>{
      'coords': instance.coords,
      'direction': instance.direction,
      'color': instance.color,
    };
