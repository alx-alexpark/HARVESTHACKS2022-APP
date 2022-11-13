// Flutter
import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harvesthacks2022/constants/colors.dart';

// Local imports
import 'package:harvesthacks2022/pages/set_creations/styled_input.dart';
import 'package:harvesthacks2022/utils/dialogs.dart';

import '../../widgets/header.dart';

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
      var termController = TextEditingController();
      var definitionController = TextEditingController();

      controllers.add(TextControllers(
        term: termController,
        definition: definitionController,
      ));

      cards.add(
        Column(
          children: [
            const Text("term"),
            TextField(
              controller: termController,
            ),
            const Text("definition"),
            TextField(
              controller: definitionController,
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Header(title: "Create"),
                  const SizedBox(height: 50),
                  StyledInput(
                    label: 'Title',
                    controller: title,
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  StyledInput(
                    label: 'Course',
                    controller: course,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: cards,
                  ),
                ],
              ),
            ),
          ),

          // Add new card
          Positioned(
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: GlobalTheme.accent,
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

                    title.text = "";
                    course.text = "";
                    cards = [];
                    controllers = [];

                    dialogSuccessfullyCreatedSet(context);
                  },
                  child: const Icon(Icons.check),
                ),
                const SizedBox(height: 20),
                FloatingActionButton(
                  backgroundColor: GlobalTheme.accent,
                  onPressed: addCard,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
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
