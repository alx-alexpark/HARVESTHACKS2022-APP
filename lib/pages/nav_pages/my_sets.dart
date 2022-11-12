import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harvesthacks2022/widgets/set_box.dart';

class MySets extends StatelessWidget {
  const MySets({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userData = snapshot.data?.data();
          var userSavedSetsRefs = (userData?["saved"] as List<dynamic>);
          print(userData?["saved"]);
          List<Widget> userLists = [];
          Future.forEach(
            userSavedSetsRefs,
            (element) async {
              var data = await element.get();
              print("Name: ");
              print(data["name"]);
              // print(data.data().toString().contains("name")
              //     ? data.get("name")
              //     : "");

              userLists.add(
                SetBox(
                  setName: data["name"],
                  cardsAmount: (data["cards"] as List).length,
                  id: data["id"],
                ),
              );
            },
          );

          return Center(child: ListView(children: userLists));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
