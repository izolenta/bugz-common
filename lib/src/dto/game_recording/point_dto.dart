import 'package:json_annotation/json_annotation.dart';

part 'point_dto.g.dart';

@JsonSerializable()
class PointDto {
  final int x;
  final int y;

  PointDto(this.x, this.y);

  factory PointDto.fromJson(Map<String, dynamic> json) => _$PointDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PointDtoToJson(this);
}