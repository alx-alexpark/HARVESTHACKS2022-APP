// Flutter
import 'package:flutter/material.dart';

// Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Local iumports
import 'package:harvesthacks2022/constants/colors.dart';

import 'package:harvesthacks2022/widgets/set_box.dart';

import 'package:harvesthacks2022/pages/discover/search_box.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search box
            const SearchBox(),
            const SizedBox(height: 50),

            // Recents
            const Text(
              "Recents",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Divider(
                color: LightTheme.foreground,
                thickness: 3.0,
              ),
            ),
            const SizedBox(height: 15.0),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 150,
              ),
              child: Expanded(
                child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream:
                      FirebaseFirestore.instance.collection("sets").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      final data = snapshot.data!.docs;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 25),
                        itemBuilder: (context, index) {
                          final e = data[index];

                          return SetBox(
                            // cardsAmount: e.data().toString().contains("cardsAmount")
                            //     ? e.get("cardsAmount")
                            //     : "",
                            cardsAmount: (e.get("cards") as List).length,
                            setName: e.data().toString().contains("name")
                                ? e.get("name")
                                : "",
                            id: e.id,
                            color: GlobalTheme.accent,
                            colorAlt: GlobalTheme.accentAlt,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 50.0),

            // Discover by subject
            const Text(
              "Discover by subject",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Divider(
                color: LightTheme.foreground,
                thickness: 3.0,
              ),
            ),
            const SizedBox(height: 15.0),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 150,
              ),
              child: Expanded(
                child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream:
                      FirebaseFirestore.instance.collection("sets").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      final data = snapshot.data!.docs;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 25,
                        ),
                        itemBuilder: (context, index) {
                          final e = data[index];

                          return SetBox(
                            // cardsAmount: e.data().toString().contains("cardsAmount")
                            //     ? e.get("cardsAmount")
                            //     : "",
                            cardsAmount: (e.get("cards") as List).length,
                            setName: e.data().toString().contains("name")
                                ? e.get("name")
                                : "",
                            id: e.data().toString().contains("id")
                                ? e.get("id")
                                : "",
                            color: GlobalTheme.accent,
                            colorAlt: GlobalTheme.accentAlt,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
