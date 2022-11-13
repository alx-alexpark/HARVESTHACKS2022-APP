import 'package:flutter/material.dart';
import 'package:harvesthacks2022/constants/colors.dart';
import 'package:harvesthacks2022/pages/flashcard_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetBox extends StatelessWidget {
  final String setName;
  final int cardsAmount;
  final String id;
  final Color color;
  final Color colorAlt;

  const SetBox({
    super.key,
    required this.setName,
    required this.cardsAmount,
    required this.id,
    required this.color,
    required this.colorAlt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var thisSet = await FirebaseFirestore.instance
            .collection("sets")
            .where("id", isEqualTo: id)
            .get();
        var title = (thisSet.docs.first.get("name") as String);
        var terms = (thisSet.docs.first.get("cards") as List);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FlashcardView(
              title: title,
              terms: terms,
            ),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 5.0,
                color: color,
              ),
            ),
            color: const Color(0xFF6159D0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                setName,
                style: TextStyle(
                  fontSize: 24,
                  color: LightTheme.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$cardsAmount terms",
                style: TextStyle(
                  fontSize: 20,
                  color: colorAlt,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
