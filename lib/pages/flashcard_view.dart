// Flutter
import 'package:flutter/material.dart';

// Flashcard widget
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

// Local imports
import 'package:harvesthacks2022/constants/colors.dart';
import 'package:harvesthacks2022/paraphrase_api.dart';

import 'package:harvesthacks2022/widgets/card_face.dart';

import 'package:harvesthacks2022/pages/flashcard_view/top.dart';

class FlashcardView extends StatefulWidget {
  final String title;
  final List terms;

  const FlashcardView({
    super.key,
    required this.title,
    required this.terms,
  });

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  late FlipCardController flipCardController;
  late int initialCardsLength;
  int index = 0;
  List proficient = [];
  List mastered = [];

  @override
  void initState() {
    super.initState();
    flipCardController = FlipCardController();
    initialCardsLength = widget.terms.length;
  }

  Widget _cardsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Top
        TopBar(
          title: widget.title,
          proficient: proficient.length,
          mastered: mastered.length,
          total: initialCardsLength,
          widget: widget,
        ),

        // Card
        FutureBuilder<Object>(
          future: ApiUtil.paraphrase(widget.terms[index]["definition"]!),
          builder: (context, snapshot) {
            String def = widget.terms[index]["definition"]!;
            if (proficient.contains(widget.terms[index])) {
              print(proficient);
              print("seen before!");
              if (snapshot.data != null) {
                def = (snapshot.data as String).replaceAll("\n", "");
              }
            }

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return FlipCard(
              controller: flipCardController,
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              front: CardFace(
                text: def,
                color: GlobalTheme.accent,
              ),
              back: CardFace(
                // text: widget.terms[index]["definition"]!,
                text: widget.terms[index]["term"]!,
                // text: (snapshot.data as String).replaceAll("\n", ""),
                color: GlobalTheme.accentAlt,
              ),
            );
          },
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
                    final e = widget.terms[index];
                    if (proficient.contains(e)) {
                      // Upgrade proficient to mastered
                      proficient.remove(e);
                      mastered.add(e);
                    } else if (!mastered.contains(e)) {
                      // Upgrade learning to proficient
                      proficient.add(e);
                    } else {
                      // Delete mastered
                      widget.terms.remove(e);
                    }
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
    TextStyle bigNumber = TextStyle(fontSize: 35);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TopBar(
          title: widget.title,
          proficient: proficient.length,
          mastered: mastered.length,
          total: initialCardsLength,
          widget: widget,
        ),

        // Statistics
        Text(
          (initialCardsLength - mastered.length - proficient.length).toString(),
          style: bigNumber,
        ),
        Container(
          child: const Text("Learning"),
        ),

        Text(
          proficient.length.toString(),
          style: bigNumber,
        ),
        Container(
          child: const Text("Proficient"),
        ),

        Text(
          mastered.length.toString(),
          style: bigNumber,
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
