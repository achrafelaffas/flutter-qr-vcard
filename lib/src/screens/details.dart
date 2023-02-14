// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      backgroundColor: tSecondaryColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: tSecondaryColor,
        title: Text(
          "My QR code",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Screenshot(
                controller: controller,
                child: Center(
                  child: _buildQRImage(widget.vCard.getFormattedString()),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Email',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.vCard.firstName} ${widget.vCard.lastName}",
                style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Email',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Text(
                widget.vCard.email[0],
                style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Phone',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Text(
                widget.vCard.cellPhone[0],
                style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Address',
                style: TextStyle(color: Colors.grey, letterSpacing: 2),
              ),
              SizedBox(height: 10),
              Text(
                widget.vCard.homeAddress.street,
                style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final image = await controller.capture();

                    if (image == null) return;

                    await saveImage(image);

                    Fluttertoast.showToast(
                        msg: "saved to gallery",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: tDarkColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: tSecondaryColor,
                      backgroundColor: tWhiteColor,
                      side: BorderSide(color: tWhiteColor),
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
                      foregroundColor: tWhiteColor,
                      side: BorderSide(color: tWhiteColor),
                      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                      shape: ContinuousRectangleBorder()),
                  child: Text("GO BACK")),
            ],
          )),
    );
  }
}

Widget _buildQRImage(String data) {
  return QrImage(
    data: data,
    size: 200.0,
    version: QrVersions.auto,
    errorCorrectionLevel: QrErrorCorrectLevel.H,
    gapless: false,
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
  );
}
