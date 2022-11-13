// Flutter
import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class SetCreationPage extends StatefulWidget {
  const SetCreationPage({super.key});

  @override
  State<SetCreationPage> createState() => _SetCreationPageState();
}

class _SetCreationPageState extends State<SetCreationPage> {
  late TextEditingController title;
  late TextEditingController course;

  List<Widget> cards = [];
  List<TextControllers> controllers = [];

  CollectionReference setsCollection =
      FirebaseFirestore.instance.collection("sets");

  @override
  void initState() {
    super.initState();

    title = TextEditingController();
    course = TextEditingController();
  }

  void addCard() {
    setState(() {
      var termC = TextEditingController();
      var definitionC = TextEditingController();
      controllers.add(TextControllers(term: termC, definition: definitionC));
      cards.add(
        Column(
          children: [
            Text("term"),
            TextField(
              controller: termC,
            ),
            Text("definition"),
            TextField(
              controller: definitionC,
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("title"),
            TextField(
              controller: title,
            ),
            Text("course"),
            TextField(
              controller: course,
            ),
            Column(
              children: cards,
            ),
            GestureDetector(
              onTap: addCard,
              child: Icon(Icons.keyboard_arrow_down_rounded),
            ),
            TextButton(
              onPressed: () async {
                setsCollection.add({
                  "name": title.text,
                  "class": course.text,
                  "id": "this is useless",
                  "cards": controllers.map((e) {
                    return {
                      "definition": e.definition.text,
                      "term": e.term.text,
                      "id": "this is useless"
                    };
                  }).toList()
                });
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class TextControllers {
  final TextEditingController term;
  final TextEditingController definition;

  TextControllers({
    required this.term,
    required this.definition,
  });
}
