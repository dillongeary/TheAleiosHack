import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class leaderboardScreen extends StatefulWidget {
  leaderboardScreen({Key? key}) : super(key: key);

  @override
  State<leaderboardScreen> createState() => leaderboardScreenState();
}

class leaderboardScreenState extends State<leaderboardScreen> {
  Map<String, int> lb = new Map();
  bool _loading = true;

  @override
  void initState() {
    getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blue), //choose your own color
              ))
            : Container());
  }

  void getLeaderboard() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("Leaderboard").get().then((var querySnapshot) {
      querySnapshot.docs.forEach((var doc) {
        final data = doc.data() as Map<String, dynamic>;
        String name = data["name"];
        int points = data["points"];
        lb[name] = points;
      });
    }, onError: (e) => print("Error getting document: $e"));
    print(lb);
    _loading = false;
  }
}
