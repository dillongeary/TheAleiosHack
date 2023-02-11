import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'leaderboardScreen.dart';
import 'rewardsScreen.dart';
import 'qrScreen.dart';
import 'package:firebase_core/firebase_core.dart';

class mainScreen extends StatefulWidget {
  mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => mainScreenState();
}

class mainScreenState extends State<mainScreen> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    getUsersScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/Green_Points_Store1.png"),
            fit: BoxFit.cover),
      ),
      child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: const Text('GreenPoints',
                        style: TextStyle(fontSize: 40, color: Colors.green, fontFamily: 'Raleway', fontWeight: FontWeight.w700))),
                Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 100,
                        child: IconButton(
                          iconSize: 120,
                          color: Colors.white,
                          onPressed: () {
                            qrScreenWait();
                          },
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                        ))),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      (score.toString() + " points"),
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    )),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Colors.white,
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => leaderboardScreen()));
                          },
                          child: Text(
                            "Leaderboard",
                            style: TextStyle(fontSize: 40, color: Colors.black),
                          ))),
                ),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 50,
                        child: TextButton(
                            style: ElevatedButton.styleFrom(
                              onSurface: Colors.white,
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => rewardsScreen()));
                            },
                            child: Text(
                              "Rewards",
                              style:
                                  TextStyle(fontSize: 40, color: Colors.black),
                            )))),
              ])),
    ));
  }

  void getUsersScore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    int newScore = 0;
    try {
      final docRef = db.collection("Leaderboard").doc(getUserID().toString());
      await docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        newScore = data["points"];
      }, onError: (e) => print("Error getting document: $e"));
    } catch (e) {}
    setState(() {
      score = newScore;
    });
  }

  int getUserID() {
    return 69; // nice
  }

  void qrScreenWait() async {
    int result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => qrScreen()));
    setState(() {
      if (result != -1) {
        score = result;
      }
    });
    if (result == -1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unsucessful, QR code invalid"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Sucessful, " + result.toString() + " is your new score"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      ));
    }
  }
}
