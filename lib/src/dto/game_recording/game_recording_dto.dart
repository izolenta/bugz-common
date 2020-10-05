import 'package:json_annotation/json_annotation.dart';

import 'game_step_dto.dart';

part 'game_recording_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GameRecordingDto {
  final Map<int, String> colorToTeam;
  final Map<String, int> teamToRating;
  final List<GameStepDto> steps;
  final String winnerId;

  GameRecordingDto(this.colorToTeam, this.teamToRating, this.steps, this.winnerId);

  factory GameRecordingDto.fromJson(Map<String, dynamic> json) => _$GameRecordingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GameRecordingDtoToJson(this);

}