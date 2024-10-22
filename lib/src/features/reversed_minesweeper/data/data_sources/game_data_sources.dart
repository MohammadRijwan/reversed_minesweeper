class GameDataSource {
  List<List<bool>> generateBombList(int boardSize) {
    return List.generate(boardSize, (_) => List.filled(boardSize, false));
  }

  List<List<bool>> generatePieceList(int boardSize) {
    return List.generate(boardSize, (_) => List.filled(boardSize, false));
  }
}
