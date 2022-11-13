import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/constants/colors.dart';
import 'package:harvesthacks2022/pages/flashcard_view/top.dart';
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
  late int initialCardsLength;
  int index = 0;
  List partiallyMaster = [];
  List master = [];

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
          author: "John Doe",
          cardsLeft: widget.terms.length,
          totalCards: initialCardsLength,
        ),

        // Card
        FutureBuilder<Object>(
            future: ApiUtil.paraphrase(widget.terms[index]["definition"]!),
            builder: (context, snapshot) {
              String def = widget.terms[index]["definition"]!;
              if (partiallyMaster.contains(widget.terms[index])) {
                print(partiallyMaster);
                print("seen before!");
                if (snapshot.data != null)
                  def = (snapshot.data as String).replaceAll("\n", "");
              }
              if (snapshot.hasData) {
                return FlipCard(
                  controller: flipCardController,
                  fill: Fill.fillBack,
                  direction: FlipDirection.VERTICAL,
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
              } else {
                return CircularProgressIndicator();
              }
            }),

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
                    if (!partiallyMaster.contains(widget.terms[index])) {
                      partiallyMaster.add(widget.terms[index]);
                    } else if (partiallyMaster.contains(widget.terms[index])) {
                      master.add(widget.terms[index]);
                      widget.terms.remove(widget.terms[index]);
                      // partiallyMaster.remove(widget.terms[index]);
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
          author: "John Doe",
          cardsLeft: widget.terms.length,
          totalCards: initialCardsLength,
        ),

        // Statistics

        Text(
            (widget.terms.length > partiallyMaster.length)
                ? (widget.terms.length - partiallyMaster.length).toString()
                : "0".toString(),
            style: bigNumber),
        Container(
          child: const Text("Learning"),
        ),
        Text(
            (partiallyMaster.length > master.length)
                ? (partiallyMaster.length - master.length).toString()
                : "0",
            style: bigNumber),
        Container(
          child: const Text("Proficient"),
        ),
        Text(master.length.toString(), style: bigNumber),
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
