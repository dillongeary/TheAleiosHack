import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mainScreen.dart';
import 'leaderboardScreen.dart';
import 'firebase_options.dart';
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
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen>  {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => mainScreen())));

    var assetsImage = new AssetImage(
        'images/new_logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height:300); //<- Creates a widget that displays an image.

    return MaterialApp(
      home: Scaffold(
        /* appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor:
              Colors.blue, //<- background color to combine with the picture :-)
        ),*/
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: image,
          ),
        ), //<- place where the image appears
      ),
    );
  }
}