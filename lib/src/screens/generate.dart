// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_king/src/constents/images.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

import '../constents/colors.dart';
import '../constents/sizes.dart';
import 'details.dart';

import 'package:email_validator/email_validator.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _photoController = TextEditingController();

  var vCard = VCard();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.orangeAccent,
        // appBar: AppBar(
        //   title: Text(
        //     "Generate",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        // ignore: avoid_unnecessary_containers
        body: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              // margin: EdgeInsets.only(top: 60, bottom: 30, left: 15, right: 15),
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Image(
                    image: AssetImage(formImage),
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "generate QR",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      if (value.contains(" ")) {
                        return 'First name must not contain spaces';
                      }
                      if (value.length < 3) {
                        return 'First name must have more than 2 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'enter your first name',
                        labelText: 'First Name',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      if (value.contains(" ")) {
                        return 'Last name must not contain spaces';
                      }
                      if (value.length < 3) {
                        return 'Last name must have more than 2 characters';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'enter your last name',
                        labelText: 'Last Name',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (!EmailValidator.validate(value!)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a phone number';
                      }
                      if (value.length != 10) {
                        return 'Mobile Number must be of 10 digit';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        labelText: 'Phone',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide an address';
                      }
                      if (value.length <= 10) {
                        return 'Address must be of 10 characters minimum';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'Enter your address',
                        labelText: 'Address',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _photoController,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                        hintText: 'Url of photo',
                        labelText: 'Photo',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          vCard.middleName = "QRKING";
                          vCard.firstName = _firstNameController.text;
                          vCard.lastName = _lastNameController.text;
                          vCard.cellPhone = _phoneController.text;
                          vCard.email = _emailController.text;
                          vCard.url = _photoController.text;
                          vCard.homeAddress.street = _addressController.text;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Details(vCard: vCard);
                          }));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Qr code generated successfully!')),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          foregroundColor: tSecondaryColor,
                          side: BorderSide(color: tSecondaryColor),
                          padding:
                              EdgeInsets.symmetric(vertical: tButtonHeight),
                          shape: ContinuousRectangleBorder()),
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: tWhiteColor,
                          backgroundColor: tSecondaryColor,
                          side: BorderSide(color: tSecondaryColor),
                          padding:
                              EdgeInsets.symmetric(vertical: tButtonHeight),
                          shape: ContinuousRectangleBorder()),
                      child: Text("go back".toUpperCase()))
                ],
              ),
            )));
  }
}