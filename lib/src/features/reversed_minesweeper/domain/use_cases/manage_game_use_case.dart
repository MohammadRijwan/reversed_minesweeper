import '../../data/repositories/game_repository.dart';
import '../entities/game_entity.dart';

class ManageGameUseCase {
  final GameRepository repository;

  ManageGameUseCase(this.repository);

  Game startGame(int boardSize) {
    List<List<bool>> bombsList = repository.getBombList(boardSize);
    List<List<bool>> piecesList = repository.getPieceList(boardSize);
    return Game(pieceList: piecesList, bombList: bombsList, explodedBombs: {});
  }
}
