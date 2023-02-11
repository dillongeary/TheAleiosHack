import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class rewardsScreen extends StatefulWidget {


rewardsScreen(
{Key? key})
    : super(key: key);

@override
State<rewardsScreen> createState() => rewardsScreenState();
}

class rewardsScreenState extends State<rewardsScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Image.asset(
        "assets/rewards_store.png",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }


}


