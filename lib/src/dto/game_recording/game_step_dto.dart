import 'package:json_annotation/json_annotation.dart';

import 'game_bug_dto.dart';
import 'point_dto.dart';

part 'game_step_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GameStepDto {
  final List<GameBugDto> bugs;
  final List<PointDto> food;
  final Map<String, int> teamToLife;

  GameStepDto(this.bugs, this.food, this.teamToLife);

  factory GameStepDto.fromJson(Map<String, dynamic> json) => _$GameStepDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameStepDtoToJson(this);

}