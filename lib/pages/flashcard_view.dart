import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/constants/colors.dart';
import 'package:harvesthacks2022/widgets/card_face.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:harvesthacks2022/paraphrase_api.dart';

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
  late FlipCardController flipCardController;
  int index = 0;
  List partiallyMaster = [];
  List master = [];

  @override
  void initState() {
    super.initState();
    flipCardController = FlipCardController();
  }

  Widget _cardsView() {
    return Column(
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
        FutureBuilder<Object>(
            future: ApiUtil.paraphrase(widget.terms[index]["definition"]!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FlipCard(
                  controller: flipCardController,
                  fill: Fill.fillBack,
                  direction: FlipDirection.VERTICAL,
                  front: CardFace(
                    text: widget.terms[index]["term"]!,
                    color: GlobalTheme.accent,
                  ),
                  back: CardFace(
                    // text: widget.terms[index]["definition"]!,
                    text: (snapshot.data as String).replaceAll("\n", ""),
                    color: GlobalTheme.accentAlt,
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),

        // Bottom
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  index++;
                  if (!flipCardController.state!.isFront) {
                    flipCardController.toggleCard();
                  }
                });
              },
              child: Text("test"),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  index++;
                  if (!flipCardController.state!.isFront) {
                    flipCardController.toggleCard();
                  }
                });
              },
              child: Text("test"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _resultsView() {
    return Column(
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    // View the cards if not at the end,
    // otherwise, view the results screen
    return Scaffold(
      body: (index < widget.terms.length) ? _cardsView() : _resultsView(),
    );
  }
}
