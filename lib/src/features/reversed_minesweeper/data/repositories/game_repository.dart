import '../data_sources/game_data_sources.dart';

class GameRepository {
  final GameDataSource dataSource;

  GameRepository(this.dataSource);

  List<List<bool>> getBombList(int boardSize) {
    return dataSource.generateBombList(boardSize);
  }

  List<List<bool>> getPieceList(int boardSize) {
    return dataSource.generatePieceList(boardSize);
  }
}
