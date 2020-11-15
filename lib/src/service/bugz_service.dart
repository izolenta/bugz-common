import 'dart:math';

import 'package:bugz_common/src/dto/game_recording/game_bug_dto.dart';
import 'package:bugz_common/src/dto/game_recording/game_recording_dto.dart';
import 'package:bugz_common/src/dto/game_recording/game_step_dto.dart';
import 'package:bugz_common/src/dto/game_recording/point_dto.dart';
import 'package:bugz_common/src/model/bug_model.dart';
import 'package:bugz_common/src/model/team_description.dart';
import 'package:bugz_common/src/util/constants.dart';
import 'package:bugz_common/src/util/object_pair.dart';
import 'package:bugz_common/src/util/object_type.dart';

class BugzService {

  final _random = Random();
  final _bots = <BugModel>[];
  final _foods = <Point>[];

  var _maxFood = 16;
  var _reducedFood = false;
  List<TeamDescription> _teams;

  List<BugModel> get getBots => _bots;
  List<Point> get getFoods => _foods;
  
  bool get isSimulationActive => _bots.where((element) => element.isAlive).map((e) => e.color).toSet().length > 1;

  int get aliveFoodCount => _reducedFood? _bots.where((element) => element.isAlive).length * 6 : _maxFood;

  void initRandomConfig(int teams, int botsInTeam, int maxFood, bool reducedFood) {
    _bots.clear();
    _foods.clear();
    _maxFood = maxFood;
    _reducedFood = reducedFood;
    for (var i=0; i<_maxFood; i++) {
      Point p;
      do {
        p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
      } while (_foods.contains(p));
      _foods.add(p);
    }
    var cnt = 0;
    for (var i=0; i<teams; i++) {
      for (var j=0; j<botsInTeam; j++) {
        Point p;
        do {
          p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
        } while (_foods.contains(p) || _bots.where((b) => b.coords == p).isNotEmpty);
        _bots.add(BugModel(getRandomGenome(), i, _random.nextInt(8), 0, p, 'g$cnt', '$i'));
        cnt++;
      }
    }
  }

  void initRepeatedConfig(List<BugModel> botList, int maxFood, bool reducedFood) {
    _bots.clear();
    _maxFood = maxFood;
    _reducedFood = _reducedFood;
    for (var i=0; i<_maxFood; i++) {
      Point p;
      do {
        p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
      } while (_foods.contains(p));
      _foods.add(p);
    }
    var cnt = 0;
    for (var i=0; i<botList.length; i++) {
      Point p;
      do {
        p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
      } while (_foods.contains(p) || _bots.where((b) => b.coords == p).isNotEmpty);
      _bots.add(BugModel(botList[i].genome, botList[i].color, _random.nextInt(8), 0, p, 'g$cnt', '$i'));
      cnt++;
    }
  }

  void initGeneticStepConfig(int teams, int botsInTeam, int maxFood, List<BugModel> genomes, int generation, bool reducedFood) {
    _bots.clear();
    _foods.clear();
    _maxFood = maxFood;
    _reducedFood = reducedFood;
    final genomesPack = [];
    final genomesNames = [];
    for (var i=0; i<8; i++) {
      for (var j=0; j<8; j++) {
        final genome = genomes[j].genome.toList();
        var name = genomes[j].name;
        if (i == j) { //mutation
          genome[_random.nextInt(64)] = _random.nextInt(64);
        }
        genomesNames.add(name);
        genomesPack.add(genome);
      }
    }
    for (var i=0; i<_maxFood; i++) {
      Point p;
      do {
        p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
      } while (_foods.contains(p));
      _foods.add(p);
    }
    var cnt = 0;
    for (var i=0; i<teams; i++) {
      for (var j=0; j<botsInTeam; j++) {
        Point p;
        do {
          p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
        } while (_foods.contains(p) || _bots.where((b) => b.coords == p).isNotEmpty);
        _bots.add(BugModel(genomesPack[cnt], i, _random.nextInt(8), generation, p, genomesNames[cnt], '$i'));
        cnt++;
      }
    }
  }

  void initPredefinedConfig(List<TeamDescription> teams, int botsInTeam, int maxFood, bool reducedFood) {
    _bots.clear();
    _foods.clear();
    _teams = teams;
    _maxFood = maxFood;
    _reducedFood = reducedFood;
    for (var i=0; i<_maxFood; i++) {
      Point p;
      do {
        p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
      } while (_foods.contains(p));
      _foods.add(p);
    }
    var cnt = 0;
    for (var team in teams) {
      for (var i=0; i<botsInTeam; i++) {
        Point p;
        do {
          p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
        } while (_foods.contains(p) || _bots.where((b) => b.coords == p).isNotEmpty);
        _bots.add(BugModel(team.genome, cnt, _random.nextInt(8), 0, p, team.name, team.id));
      }
      cnt++;
    }
  }

  void processGeneticSimulation([bool stopWhenOneTeamLost = true]) {
    while(_bots.where((element) => element.isAlive).isNotEmpty && (isSimulationActive || !stopWhenOneTeamLost)) {
      processSimulationStep(stopWhenOneTeamLost: stopWhenOneTeamLost);
      if (_bots.any((element) => element.score > 1000000)) {
        print('Bot is too smart');
        break;
      }
    }
  }

  GameRecordingDto runMatchInBackground(List<TeamDescription> teams) {
    initPredefinedConfig(teams, 16, 32, true);
    final steps = <GameStepDto>[];
    final ids = _bots.map((e) => e.id).toSet();
    final colorToTeam = <int, String>{};
    for (var id in ids) {
      colorToTeam[_bots.firstWhere((element) => element.id == id).color] = id;
    }
    steps.add(_recordStep());
    while(isSimulationActive) {
      processSimulationStep();
      steps.add(_recordStep());
    }

    final winnerId = _bots.firstWhere((b) => b.isAlive, orElse: () => null)?.id?? teams.last.id;

    final ratings = recalculateRatings(teams[0], teams[1], winnerId);
    print([ratings.first, ratings.second]);

    final teamToRating = <String, int>{
      teams[0].id : ratings.first,
      teams[1].id : ratings.second,
    };
    return GameRecordingDto(colorToTeam, teamToRating, steps, winnerId);
  }

  GameStepDto _recordStep() {
    final teamToLife = <String, int>{};
    for (var team in _teams) {
      teamToLife[team.id] =
          _bots.where((b) => b.id == team.id).toList().map((e) => e.life).reduce((a, b) => a + b);
    }
    final foods = <PointDto>[];
    for (var food in _foods) {
      foods.add(PointDto(food.x, food.y));
    }
    final bots = <GameBugDto>[];
    for (var bot in _bots.where((element) => element.isAlive)) {
      bots.add(GameBugDto(
        PointDto(bot.coords.x, bot.coords.y),
        bot.direction,
        bot.color,
      ));
    }
    return GameStepDto(bots, foods, teamToLife);
  }
  
  void processSimulationStep({bool stopWhenOneTeamLost = true}) {
    for (var i = 0; i < _bots.length; i++) {
      if (!_bots[i].isAlive || (stopWhenOneTeamLost && !isSimulationActive)) {
        continue;
      }
      var commandCount = 0;
      var isWorking = true;
      final bot = _bots[i];
      while (isWorking) {
        final command = bot.currentCommand;
        if (command < 8) {
          _performMoveCommand(bot, command);
          isWorking = false;
        }
        if (command >= 8 && command < 16) {
          _performActionCommand(bot, command % 8);
          isWorking = false;
        }
        if (command >= 16 && command < 24) {
          _performLookCommand(bot, command % 8);
          commandCount++;
          if (commandCount > 9) {
            isWorking = false;
          }
        }
        if (command >= 24 && command < 32) {
          _performTurnCommand(bot, command % 8);
          commandCount++;
          if (commandCount > 9) {
            isWorking = false;
          }
        }
        if (command >= 32) {
          _performJumpCommand(bot, command);
          commandCount++;
          if (commandCount > 9) {
            isWorking = false;
          }
        }
      }
      bot.addScore();
      bot.spendLife();
    }
  }

  ObjectThree<int, List<BugModel>, int> processStats() {
    _bots.sort((a, b) => b.score.compareTo(a.score));
    return ObjectThree(_bots.first.generation+1, _bots.take(8).toList(), _bots.first.score);
  }

  List<int> getRandomGenome() {
    final result = <int>[];
    for (var i=0; i<genomeLength; i++) {
      result.add(_random.nextInt(64));
    }
    return result;
  }

  void _performMoveCommand(BugModel bot, int command) {
    final newCoords = _getNewCoords(command, bot);
    switch (newCoords.first) {
      case ObjectType.enemy:
        bot.die();
//        bot.skipPointerIfEnemy();
        break;
      case ObjectType.wall:
        bot.skipPointerIfWall();
        break;
      case ObjectType.friend:
        bot.skipPointerIfFriend();
        break;
      case ObjectType.food:
        bot.moveTo(newCoords.second);
        bot.ateFood();
        bot.skipPointerIfFood();
        _foods.remove(newCoords.second);
        if (_foods.length < (min(_maxFood, aliveFoodCount))) {
          _foods.add(_getNewFood());
        }
        break;
      case ObjectType.empty:
        bot.moveTo(newCoords.second);
        bot.skipPointerIfEmpty();
        break;
    }
  }

  void _performActionCommand(BugModel bot, int command) {
    final newCoords = _getNewCoords(command, bot);
    switch (newCoords.first) {
      case ObjectType.enemy:
        newCoords.third.die();
        bot.ateEnemy();
        bot.skipPointerIfEnemy();
        break;
      case ObjectType.wall:
        bot.skipPointerIfWall();
        break;
      case ObjectType.friend:
        bot.skipPointerIfFriend();
        break;
      case ObjectType.food:
        bot.ateFood();
        bot.skipPointerIfFood();
        _foods.remove(newCoords.second);
        if (_foods.length < (min(_maxFood, aliveFoodCount))) {
          _foods.add(_getNewFood());
        }
        break;
      case ObjectType.empty:
        bot.skipPointerIfEmpty();
        break;
    }
  }

  void _performLookCommand(BugModel bot, int command) {
    final newCoords = _getNewCoords(command, bot);
    switch (newCoords.first) {
      case ObjectType.enemy:
        bot.skipPointerIfEnemy();
        break;
      case ObjectType.wall:
        bot.skipPointerIfWall();
        break;
      case ObjectType.friend:
        bot.skipPointerIfFriend();
        break;
      case ObjectType.food:
        bot.skipPointerIfFood();
        break;
      case ObjectType.empty:
        bot.skipPointerIfEmpty();
        break;
    }
  }

  void _performTurnCommand(BugModel bot, int command) {
    bot.setDirection((bot.direction + command) % 8);
    bot.skipPointerToNext();
  }

  void _performJumpCommand(BugModel bot, int command) {
    bot.skipPointer(command);
  }

  ObjectThree<ObjectType, Point, BugModel> _getNewCoords(int command, BugModel bot) {
    final direction = (bot.direction) % 8;
    var newCoords = bot.coords + moveVectors[direction];
    if (newCoords.x < 0 || newCoords.x >= fieldWidthParam || newCoords.y < 0 || newCoords.y >= fieldHeightParam) {
      return ObjectThree(ObjectType.wall, bot.coords, null);
    }
    final botOnTarget = _getBotOnTarget(newCoords);
    if (botOnTarget?.color == bot.color) {
      return ObjectThree(ObjectType.friend, bot.coords, botOnTarget);
    }
    if (botOnTarget != null) {
      return ObjectThree(ObjectType.enemy, newCoords, botOnTarget);
    }
    if (_foods.contains(newCoords)) {
      return ObjectThree(ObjectType.food, newCoords, null);
    }
    return ObjectThree(ObjectType.empty, newCoords, null);
  }

  BugModel _getBotOnTarget(Point p) {
    return _bots.singleWhere((b) => b.coords == p && b.isAlive, orElse: () => null);
  }

  Point _getNewFood() {
    Point p;
    do {
      p = Point(_random.nextInt(fieldWidthParam), _random.nextInt(fieldHeightParam));
    } while (_foods.contains(p) || _bots.where((b) => b.coords == p).isNotEmpty);
    return p;
  }

  ObjectPair<int, int> recalculateRatings(TeamDescription td1, TeamDescription td2, String winnerId) {
    var diff1 = td2.rating - td1.rating;
    if (diff1 < -400) { diff1 = -400;}
    if (diff1 > 400) { diff1 = 400;}
    var diff2 = td1.rating - td2.rating;
    if (diff2 < -400) { diff2 = -400;}
    if (diff2 > 400) { diff2 = 400;}

    final k1 = td1.gamesPlayed < 30? 40 : td1.rating > 2400? 10 : 20;
    final k2 = td2.gamesPlayed < 30? 40 : td2.rating > 2400? 10 : 20;

    final dr1 = 1/(1 + pow(10, diff1/400));
    final dr2 = 1/(1 + pow(10, diff2/400));
    final nr1 = td1.rating + k1 * ((winnerId == td1.id? 1 : 0) - dr1);
    final nr2 = td2.rating + k2 * ((winnerId == td2.id? 1 : 0) - dr2);
    return ObjectPair(nr1.toInt(), nr2.toInt());
  }
}