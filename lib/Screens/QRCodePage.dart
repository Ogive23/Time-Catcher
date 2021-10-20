import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Custom Widgets/FriendQRCodeScanner.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  late double w, h;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              elevation: 2.0,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 50),
                child: Column(
                  children: [
                    Text(
                      'Your QR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Delius'),
                    ),
                    QrImage(
                      data: List.generate(10, (index) => Random().nextInt(500))
                          .join(),
                      version: QrVersions.auto,
                      size: w / 2,
                      gapless: false,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              child: Container(
                padding:
                EdgeInsets.symmetric(horizontal: w / 20, vertical: h / 50),
                child: Column(
                  children: [
                    Text(
                      'Your Invitation Code',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Delius'),
                    ),
                    Text(
                      List.generate(10, (index) => Random().nextInt(500))
                          .join(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Delius'),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/animations/70533-qr-code.json',
                            width: w / 3),
                        SizedBox(width: w / 3, child: Divider()),
                        Padding(
                          padding: EdgeInsets.only(bottom: h / 100),
                          child: Text(
                            'Generate New QR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Delius'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendQRCodeScanner(),
                        ));
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                            'assets/animations/68692-qr-code-scanner.json',
                            width: w / 3),
                        SizedBox(width: w / 3, child: Divider()),
                        Padding(
                          padding: EdgeInsets.only(bottom: h / 100),
                          child: Text('Add a Friend',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Delius')),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
