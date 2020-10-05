import 'dart:convert';
import 'dart:math';

import 'package:bugz_common/src/util/constants.dart';

class BugModel {

  static const maxLife = 90;

  final List<int> genome;
  final int color;
  final int generation;
  final String name;
  final String id;

  int _direction;

  Point _coords;
  int _pointer = 0;
  int _life = 20;
  int _score = 0;

  int get direction => _direction;
  int get life => _life;
  int get score => _score;
  Point get coords => _coords;

  BugModel(this.genome, this.color, int direction, this.generation, Point coords, this.name, this.id) {
    _coords = coords;
    _direction = direction;
  }

  bool get isAlive => _life > 0;
  int get currentCommand => genome[_pointer];

  Map<String, dynamic> toJson() => {
      'generation': generation,
      'genome': jsonEncode(genome),
    };

  void skipPointer(int value) {
    _pointer = (_pointer + value) % genomeLength;
  }

  void skipPointerToNext() => skipPointer(1);

  void skipPointerIfWall() => skipPointer(skipIfWall);

  void skipPointerIfEnemy() => skipPointer(skipIfEnemy);

  void skipPointerIfFriend() => skipPointer(skipIfFriend);

  void skipPointerIfFood() => skipPointer(skipIfFood);

  void skipPointerIfEmpty() => skipPointer(skipIfEmpty);

  void die() {
    _life = 0;
  }

  void spendLife() {
    _life = max(_life-1, 0);
  }

  void addScore([int score=1]) {
    _score+=score;
  }

  void ateFood() {
    _life = min(_life+20, maxLife);
  }

  void ateEnemy() {
    _life = min(_life+20, maxLife);
  }

  void moveTo(Point p) {
    _coords = p;
  }

  void setDirection(int direction) {
    _direction = direction;
  }

}