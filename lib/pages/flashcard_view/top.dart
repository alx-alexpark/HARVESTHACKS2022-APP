// Flutter
import 'package:flutter/material.dart';

// Number formatting
import 'package:intl/intl.dart';

// Progress bar
import 'package:percent_indicator/linear_percent_indicator.dart';

// Local imports
import 'package:harvesthacks2022/constants/colors.dart';

class TopBar extends StatelessWidget {
  final percentFormat = NumberFormat('##0%', 'EN_US');

  final String title;
  final int proficient;
  final int mastered;
  final int total;

  TopBar({
    super.key,
    required this.title,
    required this.proficient,
    required this.mastered,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final wordsLeft = total - mastered;
    double proficientPercentage = proficient / total;
    double masteredPercentage = mastered / total;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_new),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.restart_alt),
              ),
            ],
          ),

          // Text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: LightTheme.foreground,
                  ),
                ),
                Text(
                  "$wordsLeft words left",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: LightTheme.foregroundAlt,
                  ),
                ),
              ],
            ),
          ),

          // Progress bar
          Stack(
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  animation: true,
                  animateFromLastPercent: true,
                  curve: Curves.elasticInOut,
                  lineHeight: 30.0,
                  animationDuration: 1000,
                  percent: proficientPercentage,
                  progressColor: GlobalTheme.accent,
                  backgroundColor: LightTheme.foreground,
                  barRadius: const Radius.circular(15.0),
                ),
              ),
              Expanded(
                child: LinearPercentIndicator(
                  animation: true,
                  animateFromLastPercent: true,
                  curve: Curves.elasticInOut,
                  lineHeight: 30.0,
                  animationDuration: 1000,
                  percent: masteredPercentage,
                  progressColor: GlobalTheme.accentAlt,
                  backgroundColor: Colors.transparent,
                  barRadius: const Radius.circular(15.0),
                  center: Text(
                    "${percentFormat.format(masteredPercentage)} mastery",
                    style: TextStyle(
                      color: LightTheme.foreground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
