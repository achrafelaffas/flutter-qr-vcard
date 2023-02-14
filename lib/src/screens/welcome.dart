// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_king/src/constents/colors.dart';
import 'package:qr_king/src/constents/images.dart';
import 'package:qr_king/src/constents/sizes.dart';
import 'package:qr_king/src/constents/text.dart';
import 'package:qr_king/src/screens/generate.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_king/src/screens/other_result.dart';
import 'package:scan/scan.dart';

import 'card.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String _scanBarcode = '';

  final ImagePicker picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  String res = '';

  String string = "";
  Future pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final path = image.path;
    res = (await Scan.parse(path))!;
    setState(() {
      string = res;
      if (string.contains("BEGIN:VCARD")) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyCard(vcString: string);
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OtherResult(result: string);
        }));
      }
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Return', false, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;

      if (_scanBarcode == "-1") {
        return;
      } else if (!_scanBarcode.contains("BEGIN:VCARD")) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OtherResult(result: _scanBarcode);
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MyCard(vcString: _scanBarcode);
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "QR KING",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
              Image(
                image: AssetImage(welcome),
                height: height * 0.5,
              ),
              Column(
                children: [
                  Text(
                    WelcomeTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    WelcomeSubTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () => scanQR(),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: tWhiteColor,
                                backgroundColor: tSecondaryColor,
                                side: BorderSide(color: tSecondaryColor),
                                padding: EdgeInsets.symmetric(
                                    vertical: tButtonHeight,
                                    horizontal: tButtonWidth),
                                shape: ContinuousRectangleBorder()),
                            child: Text(
                              "Scan".toUpperCase(),
                              style: TextStyle(color: Colors.orange),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return MyForm();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: tWhiteColor,
                                backgroundColor: tSecondaryColor,
                                side: BorderSide(color: tSecondaryColor),
                                padding: EdgeInsets.symmetric(
                                    vertical: tButtonHeight,
                                    horizontal: tButtonWidth),
                                shape: ContinuousRectangleBorder()),
                            child: Text(
                              "Generate".toUpperCase(),
                              style: TextStyle(color: Colors.orange),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () => pickImage(),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.amber,
                          width: 1.0, // Underline thickness
                        ))),
                        child: Text(
                          "Scan code from image?",
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
