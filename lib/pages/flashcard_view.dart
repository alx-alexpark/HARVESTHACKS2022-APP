import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/constants/colors.dart';
import 'package:harvesthacks2022/widgets/card_face.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FlashcardView extends StatefulWidget {
  final List terms;

  const FlashcardView({
    super.key,
    required this.terms,
  });

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top
          Padding(
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
                      "John Doe",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: LightTheme.foreground,
                      ),
                    ),

                    // Word count
                    Text(
                      "100 words",
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
                    percent: 0.8,
                    center: const Text("80.0%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                    barRadius: const Radius.circular(15.0),
                  ),
                ),
              ],
            ),
          ),

          // Card
          FlipCard(
            fill: Fill.fillBack,
            direction: FlipDirection.HORIZONTAL, // default
            front: CardFace(
              text: widget.terms[index]["term"]!,
              color: GlobalTheme.accent,
            ),
            back: CardFace(
              text: widget.terms[index]["definition"]!,
              color: GlobalTheme.accentAlt,
            ),
          ),

          // Bottom
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Text("test"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
