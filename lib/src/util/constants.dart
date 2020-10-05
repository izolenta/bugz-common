import 'dart:math';

const fieldWidthParam = 30;
const fieldHeightParam = 20;

const genomeLength = 64;

const skipIfEnemy = 1;
const skipIfWall = 2;
const skipIfFriend = 3;
const skipIfFood = 4;
const skipIfEmpty = 5;

const moveVectors = [
  Point(0, -1),
  Point(1, -1),
  Point(1, 0),
  Point(1, 1),
  Point(0, 1),
  Point(-1, 1),
  Point(-1, -0),
  Point(-1, -1),
];