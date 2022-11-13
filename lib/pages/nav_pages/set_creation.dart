import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SetCreationPage extends StatefulWidget {
  const SetCreationPage({super.key});

  @override
  State<SetCreationPage> createState() => _SetCreationPageState();
}

class _SetCreationPageState extends State<SetCreationPage> {
  late TextEditingController title;
  late TextEditingController course;

  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();

    title = TextEditingController();
    course = TextEditingController();
  }

  void addCard() {
    setState(() {
      cards.add(
        Column(
          children: [
            Text("term"),
            TextField(),
            Text("definition"),
            TextField(),
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
              onPressed: () {},
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
