import 'package:flutter/material.dart';
import 'package:revered_minesweeper/src/features/reversed_minesweeper/domain/entities/game_entity.dart';

class DragDropWidget extends StatelessWidget {
  final Game game;
  final int row;
  final int col;
  const DragDropWidget(
      {super.key, required this.game, required this.row, required this.col});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
          color: game.pieceList[row][col]
              ? Colors.transparent
              : game.explodedBombs['$row-$col'] ??
                      false // Change color if bomb exploded
                  ? Colors.transparent // Indicate explosion with red color
                  : Colors.white,
        ),
        child: game.pieceList[row][col] &&
                !game.explodedBombs.containsKey('$row-$col')
            ? Draggable<bool>(
                data: true,
                feedback: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                childWhenDragging: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: game.explodedBombs['$row-$col'] ?? false
                        ? Colors.transparent
                        : Colors.blueAccent,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
