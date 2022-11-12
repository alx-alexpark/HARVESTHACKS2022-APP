import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class SetBox extends StatelessWidget {
  final String setName;
  final int cardsAmt;
  final String id;

  const SetBox(
      {super.key,
      required this.setName,
      required this.cardsAmt,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: 100,
      height: 100,
      color: const Color(0xFF6159D0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(setName, style: TextStyle(fontSize: 25)),
          Text("$cardsAmt terms", style: TextStyle(fontSize: 12))
        ],
      ),
    );
  }
}
