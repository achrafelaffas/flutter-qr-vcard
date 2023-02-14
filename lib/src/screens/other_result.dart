// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_king/src/screens/style.dart';

class OtherResult extends StatelessWidget {
  OtherResult({super.key, required this.result});

  String result;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppStyle.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Scan result : ".toUpperCase(),
                style: TextStyle(fontSize: 20, color: AppStyle.accentColor),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 300.0,
                child: TextFormField(
                  initialValue: result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type the Data",
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              RawMaterialButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: result));
                },
                fillColor: AppStyle.accentColor,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 36.0,
                  vertical: 16.0,
                ),
                child: const Text(
                  "Copy to clipboard",
                ),
              )
            ],
          ),
        ));
  }
}
