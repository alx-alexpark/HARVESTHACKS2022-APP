import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/constants/colors.dart';
import 'package:harvesthacks2022/pages/flashcard_view/top.dart';
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
  late FlipCardController flipCardController;
  int index = 0;

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
        TopBar(
          author: "John Doe",
          cardsLeft: 10,
          totalCards: 20,
        ),

        // Card
        FlipCard(
          controller: flipCardController,
          fill: Fill.fillBack,
          direction: FlipDirection.VERTICAL,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 75.0,
                ),
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
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 75.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _resultsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TopBar(
          author: "John Doe",
          cardsLeft: 10,
          totalCards: 20,
        ),

        // Statistics
        Container(
          child: const Text("Learning"),
        ),
        Container(
          child: const Text("Proficient"),
        ),
        Container(
          child: const Text("Mastered"),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GlobalTheme.accent,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 20.0,
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: LightTheme.background,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
