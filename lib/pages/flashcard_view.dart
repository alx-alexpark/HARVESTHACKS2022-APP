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
import 'package:harvesthacks2022/widgets/card_overlay.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FlashcardView extends StatefulWidget {
  final String title;
  List terms;

  FlashcardView({
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
  List proficient = [];
  List mastered = [];

  List nextList = [];

  @override
  void initState() {
    super.initState();
    flipCardController = FlipCardController();
    initialCardsLength = widget.terms.length;
  }

  Widget _resultsView() {
    TextStyle bigNumber = const TextStyle(fontSize: 35);
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
        const Text("Learning"),

        Text(
          proficient.length.toString(),
          style: bigNumber,
        ),
        const Text("Proficient"),

        Text(
          mastered.length.toString(),
          style: bigNumber,
        ),
        const Text("Mastered"),

        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    if (widget.terms.isEmpty) {
                      widget.terms = nextList;
                    }
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
      // body: (index < widget.terms.length) ? _cardsView() : _resultsView(),
      body: Stack(
        children: [
          _resultsView(),
          SwipableStack(
            allowVerticalSwipe: false,
            onSwipeCompleted: (_, direction) {
              setState(() {
                final e = widget.terms[0];
                if (direction == SwipeDirection.right) {
                  if (proficient.contains(e)) {
                    // Upgrade proficient to mastered
                    proficient.remove(e);
                    mastered.add(e);

                    nextList.add(e);
                  } else if (!mastered.contains(e)) {
                    // Upgrade learning to proficient
                    proficient.add(e);

                    nextList.add(e);
                  } // Mastered elements are ignored

                } else {
                  nextList.add(e);
                }

                widget.terms.removeAt(0);
              });
            },
            itemCount: widget.terms.length,
            builder: (context, swipeProperty) {
              return Stack(
                children: [
                  FutureBuilder<Widget>(
                    future: buildCard(),
                    builder: (context, snapshot) {
                      return snapshot.data ?? const CircularProgressIndicator();
                    },
                  ),

                  // more custom overlay possible than with overlayBuilder
                  if (swipeProperty.stackIndex == 0 &&
                      swipeProperty.direction != null)
                    CardOverlay(
                      swipeProgress: swipeProperty.swipeProgress,
                      direction: swipeProperty.direction!,
                    )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Widget> buildCard() async {
    String def = widget.terms[0]["definition"]!;

    if (proficient.contains(widget.terms[0])) {
      final generated = await ApiUtil.paraphrase(def);
      def = generated.replaceAll("\n", "");
    }

    return Padding(
      padding: const EdgeInsets.only(top: 180),
      child: FlipCard(
        controller: flipCardController,
        fill: Fill.fillBack,
        direction: FlipDirection.HORIZONTAL,
        front: CardFace(
          text: def,
          color: GlobalTheme.accent,
        ),
        back: CardFace(
          text: widget.terms[0]["term"]!,
          color: GlobalTheme.accentAlt,
        ),
      ),
    );
  }
}
