import 'package:flutter/material.dart';
import 'package:harvesthacks2022/widgets/set_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: FirebaseFirestore.instance.collection("sets").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data =
                (snapshot as AsyncSnapshot<QuerySnapshot<Object?>>).data!.docs;
            return ListView(
              children: data.map((e) {
                return SetBox(
                    // cardsAmt: e.data().toString().contains("cardsAmount")
                    //     ? e.get("cardsAmount")
                    //     : "",
                    cardsAmt: (e.get("cards") as List).length,
                    setName: e.data().toString().contains("name")
                        ? e.get("name")
                        : "",
                    id: e.data().toString().contains("id") ? e.get("id") : "");
              }).toList(),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
