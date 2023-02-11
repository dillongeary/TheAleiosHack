import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'leaderboardScreen.dart';
import 'mapScreen.dart';
import 'qrScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                  child: const Text('QR-Newable',
                      style: TextStyle(
                          fontSize: 40, color: Colors.green))
                  ),

                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Colors.green,
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => qrScreen()));
                              },
                              child: Text(
                                "Scan",
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              )))),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Colors.green,
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => mapScreen()));
                              },
                              child: Text(
                                "Map",
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              )))),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              style: ElevatedButton.styleFrom(
                                onSurface: Colors.green,
                                primary: Colors.green,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => leaderboardScreen()));
                              },
                              child: Text(
                                "Leaderboard",
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              )))),
                  Align(
                      alignment: Alignment.center,
                              child: Text(
                                ("Score: " + score.toString()),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )),
                ]
            )
        )
    );
  }
}
