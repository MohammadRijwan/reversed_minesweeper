import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revered_minesweeper/src/features/reversed_minesweeper/domain/entities/game_entity.dart';

import '../../domain/providers/game_provider.dart';
import 'drag_drop_widget.dart';
import 'explosion_widget.dart';

class GameBoard extends ConsumerStatefulWidget {
  final Game game;
  const GameBoard({super.key, required this.game});

  @override
  ConsumerState<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends ConsumerState<GameBoard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(gameProvider.notifier).startTimer(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameNotifier = ref.watch(gameProvider.notifier);
    return Column(
      children: [
        Text(
          'Discovered Bombs: ${widget.game.discoveredBombs ?? 0}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('Timer: ${gameNotifier.timerCount ?? 0}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        if (gameNotifier.boardSize != null)
          Flexible(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gameNotifier.boardSize,
              ),
              itemCount: gameNotifier.boardSize * gameNotifier.boardSize,
              itemBuilder: (context, index) {
                int row = index ~/ gameNotifier.boardSize;
                int col = index % gameNotifier.boardSize;
                return Stack(
                  children: [
                    if (widget.game.explodedBombs['$row-$col'] ??
                        false) // Show bomb icon if exploded
                      const Positioned.fill(
                        child: ExplosionWidget(),
                      ),
                    DragTarget<bool>(
                      builder: (context, candidateData, rejectedData) {
                        return DragDropWidget(
                          game: widget.game,
                          row: row,
                          col: col,
                        );
                      },
                      onWillAcceptWithDetails: (data) =>
                          !widget.game.pieceList[row][col],
                      onAcceptWithDetails: (data) {
                        gameNotifier.onAccept(row, col, context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  const Text(' *Empty Box'),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.blueAccent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  const Text(' *Piece Box'),
                ],
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ],
    );
  }
}

// class GameBoard extends ConsumerWidget {
//   final Game game;
//
//   const GameBoard({super.key, required this.game});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final gameNotifier = ref.watch(gameProvider.notifier);
//     return Column(
//       children: [
//         Text(
//           'Discovered Bombs: ${game.discoveredBombs}',
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5.0),
//         Container(
//           width: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.white,
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 5,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Text('Timer: ${gameNotifier.timerCount}',
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.red)),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10.0),
//         Expanded(
//           child: GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: gameNotifier.boardSize,
//             ),
//             itemCount: gameNotifier.boardSize * gameNotifier.boardSize,
//             itemBuilder: (context, index) {
//               int row = index ~/ gameNotifier.boardSize;
//               int col = index % gameNotifier.boardSize;
//               return Stack(
//                 children: [
//                   if (game.explodedBombs['$row-$col'] ??
//                       false) // Show bomb icon if exploded
//                     const Positioned.fill(
//                       child: ExplosionWidget(),
//                     ),
//                   DragTarget<bool>(
//                     builder: (context, candidateData, rejectedData) {
//                       return DragDropWidget(
//                         game: game,
//                         row: row,
//                         col: col,
//                       );
//                     },
//                     onWillAcceptWithDetails: (data) =>
//                         !game.pieceList[row][col],
//                     onAcceptWithDetails: (data) {
//                       gameNotifier.onAccept(row, col, context);
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       color: Colors.white,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Text(' *Empty Box'),
//                 ],
//               ),
//               const SizedBox(height: 5.0),
//               Row(
//                 children: [
//                   Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       color: Colors.blueAccent,
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Text(' *Piece Box'),
//                 ],
//               ),
//               const SizedBox(height: 15.0),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
