import 'dart:collection';

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
  List names = [];
  List points = [];
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
            : Container(
          margin: EdgeInsets.all(32),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Align(
                  alignment: Alignment.center,
                  child: const Text('GreenPoints',
                      style: TextStyle(fontSize: 40, color: Colors.green))),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    child: Center(
                        child: Text('${names[index]}: ${points[index]}',
                          style: TextStyle(fontSize: 30),
                        )
                    ),
                  );
                }
          )
          ]),
            )
    );

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

    // Sort the lb map by points
    var sortedKeys = lb.keys.toList(growable:false)
      ..sort((k1, k2) => lb[k2]!.compareTo(lb[k1]!));
    LinkedHashMap<String, int> sortedMap = new LinkedHashMap.fromIterable(sortedKeys, key: (k) => k, value: (k) => lb[k]!);
    lb = sortedMap;

    names = sortedMap.keys.toList();

    for (String i in names) {
      points.add(sortedMap[i]);
    }

    setState((){
      _loading = false;
    });


  }
}
