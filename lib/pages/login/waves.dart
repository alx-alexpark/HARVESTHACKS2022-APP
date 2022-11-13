import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomWaves extends StatelessWidget {
  const BottomWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 0.0,
      child: SvgPicture.asset(
        'assets/images/waves.svg',
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
