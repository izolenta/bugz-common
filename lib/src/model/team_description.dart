library bugz.team_description;

import 'package:built_value/built_value.dart';

part 'team_description.g.dart';

abstract class TeamDescription implements Built<TeamDescription, TeamDescriptionBuilder> {
  factory TeamDescription([void Function(TeamDescriptionBuilder b) updates]) = _$TeamDescription;

  TeamDescription._();

  String get name;
  String get id;
  List<int> get genome;
  int get rating;
  String get ownerName;
  String get ownerId;
}