import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/data_sources/game_data_sources.dart';
import '../../data/repositories/game_repository.dart';
import '../../presentation/screens/final_screen.dart';
import '../entities/game_entity.dart';
import '../use_cases/manage_game_use_case.dart';

final gameProvider =
    StateNotifierProvider.autoDispose<GameNotifier, Game>((ref) {
  final repository = GameRepository(GameDataSource());
  final useCase = ManageGameUseCase(repository);

  return GameNotifier(useCase);
});

class GameNotifier extends StateNotifier<Game> {
  final ManageGameUseCase useCase;
  Timer? _timer;

  int bombCount = 20;
  int boardSize = 10;
  int timerCount = 1;

  GameNotifier(this.useCase)
      : super(Game(
          bombList: [],
          pieceList: [],
          explodedBombs: {},
        )) {
    startNewGame();
  }
  void startNewGame() {
    state = useCase.startGame(boardSize);
    placeBombs();
    placePieces();
  }

  void placeBombs() {
    Random random = Random();
    int placedBombs = 0;
    while (placedBombs < bombCount) {
      int row = random.nextInt(boardSize);
      int col = random.nextInt(boardSize);
      if (!state.bombList[row][col]) {
        state.bombList[row][col] = true;
        state.explodedBombs.addAll({'$row-$col': false});
        placedBombs++;
      }
    }
  }

  void placePieces() {
    Random random = Random();
    int piecesToPlace = (boardSize * boardSize - bombCount) ~/ 2;
    while (piecesToPlace > 0) {
      int row = random.nextInt(boardSize);
      int col = random.nextInt(boardSize);
      if (!state.bombList[row][col] && !state.pieceList[row][col]) {
        state.pieceList[row][col] = true;
        piecesToPlace--;
      }
    }
  }

  void startTimer({required BuildContext context}) {
    timerCount = 1;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCount++;
      if (timerCount == 11) {
        explodeRandomBomb(
          context: context,
        );
        timerCount = 1;
      }
      state = state.copyWith();
    });
  }

  void explodeRandomBomb({required BuildContext context}) {
    List<Point<int>> unexplodedBombs = [];
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        if (state.bombList[i][j]) {
          unexplodedBombs.add(Point(i, j));
        }
      }
    }

    if (unexplodedBombs.isNotEmpty) {
      Point<int> randomBomb =
          unexplodedBombs[Random().nextInt(unexplodedBombs.length)];
      state.bombList[randomBomb.x][randomBomb.y] = false;
      state.explodedBombs['${randomBomb.x}-${randomBomb.y}'] = true;
      checkGameOver(context: context);
    }
  }

  void checkGameOver({required BuildContext context}) {
    bool allBombsGone =
        state.bombList.every((row) => row.every((bomb) => !bomb));
    if (allBombsGone) {
      context.pushNamed(FinalScreen.route, extra: state.discoveredBombs);
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void onAccept(int row, int col, BuildContext context) {
    state.pieceList[row][col] = true;
    if (state.bombList[row][col]) {
      state.discoveredBombs++;
      state.bombList[row][col] = false;
      state.explodedBombs['$row-$col'] = true;
      timerCount = 1;
    }
    checkGameOver(context: context);
    state = state.copyWith();
  }
}
