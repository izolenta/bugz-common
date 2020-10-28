// GENERATED CODE - DO NOT MODIFY BY HAND

part of bugz_common.team_description;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeamDescription extends TeamDescription {
  @override
  final String name;
  @override
  final String id;
  @override
  final List<int> genome;
  @override
  final int rating;
  @override
  final String ownerName;
  @override
  final String ownerId;
  @override
  final int gamesPlayed;
  @override
  final bool forTournament;

  factory _$TeamDescription([void Function(TeamDescriptionBuilder) updates]) =>
      (new TeamDescriptionBuilder()..update(updates)).build();

  _$TeamDescription._(
      {this.name,
      this.id,
      this.genome,
      this.rating,
      this.ownerName,
      this.ownerId,
      this.gamesPlayed,
      this.forTournament})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('TeamDescription', 'name');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('TeamDescription', 'id');
    }
    if (genome == null) {
      throw new BuiltValueNullFieldError('TeamDescription', 'genome');
    }
    if (rating == null) {
      throw new BuiltValueNullFieldError('TeamDescription', 'rating');
    }
    if (ownerName == null) {
      throw new BuiltValueNullFieldError('TeamDescription', 'ownerName');
    }
    if (ownerId == null) {
      throw new BuiltValueNullFieldError('TeamDescription', 'ownerId');
    }
  }

  @override
  TeamDescription rebuild(void Function(TeamDescriptionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeamDescriptionBuilder toBuilder() =>
      new TeamDescriptionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeamDescription &&
        name == other.name &&
        id == other.id &&
        genome == other.genome &&
        rating == other.rating &&
        ownerName == other.ownerName &&
        ownerId == other.ownerId &&
        gamesPlayed == other.gamesPlayed &&
        forTournament == other.forTournament;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, name.hashCode), id.hashCode),
                            genome.hashCode),
                        rating.hashCode),
                    ownerName.hashCode),
                ownerId.hashCode),
            gamesPlayed.hashCode),
        forTournament.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TeamDescription')
          ..add('name', name)
          ..add('id', id)
          ..add('genome', genome)
          ..add('rating', rating)
          ..add('ownerName', ownerName)
          ..add('ownerId', ownerId)
          ..add('gamesPlayed', gamesPlayed)
          ..add('forTournament', forTournament))
        .toString();
  }
}

class TeamDescriptionBuilder
    implements Builder<TeamDescription, TeamDescriptionBuilder> {
  _$TeamDescription _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  List<int> _genome;
  List<int> get genome => _$this._genome;
  set genome(List<int> genome) => _$this._genome = genome;

  int _rating;
  int get rating => _$this._rating;
  set rating(int rating) => _$this._rating = rating;

  String _ownerName;
  String get ownerName => _$this._ownerName;
  set ownerName(String ownerName) => _$this._ownerName = ownerName;

  String _ownerId;
  String get ownerId => _$this._ownerId;
  set ownerId(String ownerId) => _$this._ownerId = ownerId;

  int _gamesPlayed;
  int get gamesPlayed => _$this._gamesPlayed;
  set gamesPlayed(int gamesPlayed) => _$this._gamesPlayed = gamesPlayed;

  bool _forTournament;
  bool get forTournament => _$this._forTournament;
  set forTournament(bool forTournament) =>
      _$this._forTournament = forTournament;

  TeamDescriptionBuilder();

  TeamDescriptionBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _id = _$v.id;
      _genome = _$v.genome;
      _rating = _$v.rating;
      _ownerName = _$v.ownerName;
      _ownerId = _$v.ownerId;
      _gamesPlayed = _$v.gamesPlayed;
      _forTournament = _$v.forTournament;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeamDescription other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TeamDescription;
  }

  @override
  void update(void Function(TeamDescriptionBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TeamDescription build() {
    final _$result = _$v ??
        new _$TeamDescription._(
            name: name,
            id: id,
            genome: genome,
            rating: rating,
            ownerName: ownerName,
            ownerId: ownerId,
            gamesPlayed: gamesPlayed,
            forTournament: forTournament);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
