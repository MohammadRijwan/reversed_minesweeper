class Game {
  final List<List<bool>> bombList;
  final List<List<bool>> pieceList;
  Map<String, bool> explodedBombs;
  int discoveredBombs;

  Game({
    required this.bombList,
    required this.pieceList,
    this.discoveredBombs = 0,
    required this.explodedBombs,
  });

  Game copyWith({
    List<List<bool>>? bombList,
    List<List<bool>>? pieceList,
    Map<String, bool>? explodedBombs,
    int? discoveredBombs,
  }) {
    return Game(
      bombList: bombList ?? this.bombList,
      pieceList: pieceList ?? this.pieceList,
      explodedBombs: explodedBombs ?? this.explodedBombs,
      discoveredBombs: discoveredBombs ?? this.discoveredBombs,
    );
  }
}
