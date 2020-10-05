import 'package:json_annotation/json_annotation.dart';

import 'point_dto.dart';

part 'game_bug_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GameBugDto {
  final PointDto coords;
  final int direction;
  final int color;

  GameBugDto(this.coords, this.direction, this.color);

  factory GameBugDto.fromJson(Map<String, dynamic> json) => _$GameBugDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameBugDtoToJson(this);
}