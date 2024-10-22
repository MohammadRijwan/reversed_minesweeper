import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinKitWidget extends StatelessWidget {
  const SpinKitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: Theme.of(context).primaryColor,
    );
  }
}
