// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

class ReadFromImg extends StatefulWidget {
  const ReadFromImg({super.key});

  @override
  State<ReadFromImg> createState() => _ReadFromImgState();
}

class _ReadFromImgState extends State<ReadFromImg> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text("choose image")),
        ),
        Center(
          child: Text(res),
        ),
      ],
    ));
  }
}
