import 'package:flutter/material.dart';
import 'leaderboardScreen.dart';
import 'mapScreen.dart';
import 'qrScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.green,
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => qrScreen()));
                },
                child: Text(
                  "Scan",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                )),
            TextButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.lightGreen,
                  primary: Colors.lightGreen,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mapScreen()));
                },
                child: Text(
                  "Map",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                )),
            TextButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.lightGreenAccent,
                  primary: Colors.lightGreenAccent,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => leaderboardScreen()));
                },
                child: Text(
                  "Leaderboard",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
