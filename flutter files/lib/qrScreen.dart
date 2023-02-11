import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:collection/collection.dart';

class qrScreen extends StatefulWidget {
  qrScreen({Key? key}) : super(key: key);

  @override
  State<qrScreen> createState() => qrScreenState();
}

class qrScreenState extends State<qrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      processQRCode(result!.code);
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    readQr();
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.orange,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void processQRCode(String? code) async {
      //code holds the number eg 5

      //"Starbucks",15612,"Vegan Milk","Reusable Cup"
      if (code != null) {
        //decoding the qr code
        final split = code.split(",");
        final Map<int, String> values = {
          for (int i = 0; i < split.length; i++) i: split[i]
        };

        final location = values[0];
        final qrid = values[1];

        int i = 2;
        List variables = [];
        while (true) {
          if (values[i] == null) {
            break;
          } else {
            variables.add(values[i]);
            i = i + 1;
          }
        }

        final now = new DateTime.now();
        final date = new DateTime(now.year, now.month, now.day);

        FirebaseFirestore db = FirebaseFirestore.instance;

        //checking for valid scan
        bool validQR = false;
        // if (variables.contains("bike")) {
        //   final docRef1 = db.collection("QRC Log").doc(getUserID())
        //   await docRef1.get().then((DocumentSnapshot doc) {
        //     final data = doc.data() as Map<String, dynamic>;
        //     if (data[qrid] == null) {
        //       validQR = true;
        //     } else if ()
        //   })
        //   if ()
        // }

        final docRef1 = db.collection("QRC Log").doc(getUserID().toString());
          await docRef1.get().then((DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            if (data[qrid] == null) {
              validQR = true;
              // Add this qr to the db
            } else {
              validQR = false;
            }
          },onError: (e) => print("Error getting document: $e")
          );

        int total;
        
        if (validQR) {
          final qrscan = <String, DateTime>{
            qrid as String:date
          };

          final qrcRef = db.collection("QRC Log").doc(getUserID().toString());
          await qrcRef.update({qrid as String:date}).then(
            (value) => print("DocumentSnapshot successfully updated!"),
            onError: (e) => print("Error updating document $e"));
        
          final docRef = db.collection("PointsLookupTable").doc(location);
          List<int> points = [];
          await docRef.get().then((DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            points = variables.map((variable) => data[variable] as int).toList();
          },onError: (e) => print("Error getting document: $e")
          );

          total = points.sum;

          //implement database
          bool existingUser = false;
          int currentPoints = 0;
          String name = "Name";

          try {
            final docRef2 = db.collection("Leaderboard");

            var doc = await docRef2.doc(getUserID().toString()).get().then((DocumentSnapshot doc) {
              final data = doc.data() as Map<String, dynamic>;
              currentPoints = data["points"];
              name = data["name"];
            },onError: (e) => print("Error getting document: $e")
            );
            existingUser = true;
          } catch (e) {
            existingUser = false;
            currentPoints = 0;
            name = "Name";
          }

          int newPoints = currentPoints + total;

          final leaderboardEntry = <String,dynamic>{
            "name":name,
            "points":newPoints
          };

          await db.collection("Leaderboard").doc(getUserID().toString()).set(leaderboardEntry).onError((e, _) => print("Error writing document: $e"));
        } else {
          print("QR code scanned already");
          //Sian add some nice error message / popup
        }
      }
  }

  int getUserID() {
    return 69; // nice
  }


}
