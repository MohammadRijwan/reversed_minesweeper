import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class ExplosionWidget extends StatefulWidget {
  const ExplosionWidget({super.key});

  @override
  State<ExplosionWidget> createState() => _ExplosionWidgetState();
}

class _ExplosionWidgetState extends State<ExplosionWidget> {
  GifController controller = GifController();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      controller.pause();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
            child: GifView.asset(
          controller: controller,
          'assets/bomb.gif',
          height: 30,
          width: 30,
        )
            // Text('💣')

            ),
      ),
    );
  }
}
