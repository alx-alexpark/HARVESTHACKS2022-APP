import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constants/colors.dart';

class TopBar extends StatelessWidget {
  final percentFormat = NumberFormat('##0%', 'EN_US');

  final String author;
  final int cardsLeft;
  final int totalCards;

  TopBar({
    super.key,
    required this.author,
    required this.cardsLeft,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = cardsLeft / totalCards;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: GlobalTheme.accent,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),

          const SizedBox(width: 10.0),

          // Name and word count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                author,
                style: TextStyle(
                  fontSize: 16.0,
                  color: LightTheme.foreground,
                ),
              ),

              // Word count
              Text(
                "$cardsLeft words left",
                style: TextStyle(
                  fontSize: 16.0,
                  color: LightTheme.foregroundAlt,
                ),
              ),
            ],
          ),

          // Progress bar
          Expanded(
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: percentage,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
              barRadius: const Radius.circular(15.0),
              center: Text(
                percentFormat.format(percentage),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
