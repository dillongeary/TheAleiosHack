import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class leaderboardScreen extends StatefulWidget {


  leaderboardScreen(
      {Key? key})
      : super(key: key);

  @override
  State<leaderboardScreen> createState() => leaderboardScreenState();
}

class leaderboardScreenState extends State<leaderboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}


  
  Map<String, int> getLeaderboard() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, int> lb = new Map();
    final docRef = db.collection("Leaderboard").docs();
    await docRef.get().then((var doc) {
      for (var i; doc) {
        final data = i.data() as Map<String, dynamic>;
        name = data["name"];
        points = data["points"];
        lb[name] = points;
      } 
    },onError: (e) => print("Error getting document: $e")
    );
    return lb
  }
