// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import 'package:vcard_maintained/vcard_maintained.dart';

import '../constents/colors.dart';
import '../constents/sizes.dart';

class Details extends StatefulWidget {
  Details({super.key, required this.vCard});

  var vCard = VCard();

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final controller = ScreenshotController();

  // ignore: dead_code
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now();
    final name = 'screenshot_$time';
    final resut = await ImageGallerySaver.saveImage(bytes, name: name);
    return resut['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Screenshot(
                controller: controller,
                child: Center(
                  child:
                      _buildQRImage(widget.vCard.getFormattedString(), height),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final image = await controller.capture();

                    if (image == null) return;

                    await saveImage(image);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: tWhiteColor,
                      backgroundColor: tSecondaryColor,
                      side: BorderSide(color: tSecondaryColor),
                      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                      shape: ContinuousRectangleBorder()),
                  child: Text('Save to gallery'.toUpperCase())),
              SizedBox(
                height: 15,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      foregroundColor: tSecondaryColor,
                      side: BorderSide(color: tSecondaryColor),
                      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                      shape: ContinuousRectangleBorder()),
                  child: Text("GO BACK")),
            ],
          )),
    );
  }
}

Widget _buildQRImage(String data, double h) {
  return Container(
      margin: EdgeInsets.only(top: h * 0.1),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.orange, width: 2)),
      child: QrImage(
        data: data,
        size: 300.0,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
        gapless: false,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ));
}
