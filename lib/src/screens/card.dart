// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, unused_import, non_constant_identifier_names, use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:simple_vcard_parser/simple_vcard_parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constents/colors.dart';
import '../constents/sizes.dart';

import 'package:flutter_contacts/flutter_contacts.dart';

class MyCard extends StatefulWidget {
  MyCard({super.key, required this.vcString});

  String vcString;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  //Reading the Vcard Variable

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String Address(str, start, end) {
      final startIndex = str.indexOf(start);
      final endIndex = str.indexOf(end, startIndex + start.length);

      return str.substring(
          startIndex + start.length, endIndex); // brown fox jumps
    }

    late VCard vc = VCard(widget.vcString);
    late Contact contact = Contact();
    String photo =
        "https://i.pinimg.com/564x/ea/83/71/ea8371f0dbbf8f8d998e02b673dc7de4.jpg";
    String name = "a";
    String email = "aa";
    String phone = "a";
    String address = "a";
    if (widget.vcString.contains("QRKING")) {
      contact = Contact.fromVCard(widget.vcString);
      try {
        photo = contact.websites.first.url;
      } catch (e) {
        debugPrint("nono");
      }
      name = "${contact.name.first} ${contact.name.last}";
      email = contact.emails.first.address;
      phone = contact.phones.first.number;
      address = contact.addresses.first.address;
    } else {
      if (vc.typedURL.toString().isNotEmpty) {
        photo = vc.typedURL.toString();
      }
      name = vc.name[0].toString();
      email = vc.typedEmail[0][0].toString();
      phone = vc.typedTelephone[0][0].toString();
      address = Address(widget.vcString, "ADR:", "TEL");
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: tSecondaryColor,
        title: Text(
          "card details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: tSecondaryColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.orange,
                backgroundImage: NetworkImage(photo),
                radius: 50,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.orange,
                    letterSpacing: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height * 0.1),
            Text(
              'Email',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Text(
              email,
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
              phone,
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
              address,
              style: TextStyle(
                  color: Colors.orange,
                  letterSpacing: 2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      String recipient = email;
                      String subject = "this is my first flluter email";
                      String body =
                          "well my friend I am writing you this email to let you know it worked";

                      final Uri emailMessage = Uri(
                        scheme: 'mailto',
                        path: recipient,
                        query:
                            'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
                      );

                      if (await canLaunchUrl(emailMessage)) {
                        await launchUrl(emailMessage);
                      } else {
                        debugPrint('error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: tWhiteColor,
                        backgroundColor: tSecondaryColor,
                        side: BorderSide(color: tWhiteColor),
                        padding: EdgeInsets.symmetric(
                            vertical: tButtonHeight, horizontal: tButtonWidth),
                        shape: ContinuousRectangleBorder()),
                    child: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final Uri sms = Uri(
                        scheme: 'sms',
                        path: phone,
                        queryParameters: <String, String>{
                          'body': Uri.encodeComponent('hello'),
                        },
                      );

                      if (await canLaunchUrl(sms)) {
                        await launchUrl(sms);
                      } else {
                        debugPrint('error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: tWhiteColor,
                        backgroundColor: tSecondaryColor,
                        side: BorderSide(color: tWhiteColor),
                        padding: EdgeInsets.symmetric(
                            vertical: tButtonHeight, horizontal: tButtonWidth),
                        shape: ContinuousRectangleBorder()),
                    child: Icon(Icons.sms_outlined),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final Uri call = Uri(
                        scheme: 'tel',
                        path: phone,
                      );

                      if (await canLaunchUrl(call)) {
                        await launchUrl(call);
                      } else {
                        debugPrint('error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: tWhiteColor,
                        backgroundColor: tSecondaryColor,
                        side: BorderSide(color: tWhiteColor),
                        padding: EdgeInsets.symmetric(
                            vertical: tButtonHeight, horizontal: tButtonWidth),
                        shape: ContinuousRectangleBorder()),
                    child: Icon(Icons.call_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => openWhatsapp(
                        context: context,
                        text: "Hello, I am writing to you...",
                        number: phone),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: tWhiteColor,
                        backgroundColor: tSecondaryColor,
                        side: BorderSide(color: tWhiteColor),
                        padding: EdgeInsets.symmetric(
                            vertical: tButtonHeight, horizontal: tButtonWidth),
                        shape: ContinuousRectangleBorder()),
                    child: Text("WhatsApp message"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";

    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp not installed")));
    }
  }
}
