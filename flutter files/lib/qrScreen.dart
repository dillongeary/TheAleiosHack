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
    print("aaa");
    //"Starbucks",15612,"Vegan Milk","Reusable Cup"
    if (code != null) {
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
      print(variables);
      print(location);


      FirebaseFirestore db = FirebaseFirestore.instance;

      final docRef = db.collection("PointsLookupTable").doc(location);
      List<int> points = [];
      await docRef.get().then((DocumentSnapshot doc) {

        final data = doc.data() as Map<String, dynamic>;
        print("IN THINGY");
        print(data);
        points = variables.map((variable) => data[variable] as int).toList();
      },onError: (e) => print("Error getting document: $e")
      );

      print(points);
      final total = points.sum;
      print(total);
    }
  }
}
