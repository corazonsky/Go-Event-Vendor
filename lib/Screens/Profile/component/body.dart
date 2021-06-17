import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/models/UserData.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firebase_storage_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/services/image_picker_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();
  File imageFile;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirestoreService>(context);
    final user = Provider.of<FirebaseAuthService>(context).getCurrentUser();
    return MainBackground(
      child: SingleChildScrollView(
        child: StreamBuilder<UserDataModel>(
            stream: database.userDataStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data;
                final String imageURL = userData.photoURL;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage: imageFile == null
                                  ? NetworkImage(imageURL)
                                  : FileImage(imageFile),
                            ),
                            Positioned(
                              left: -16,
                              bottom: 0,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFFF5F6F9)),
                                  ),
                                  onPressed: () async {
                                    imageFile = null;
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.refresh,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -16,
                              bottom: 0,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFFF5F6F9)),
                                  ),
                                  onPressed: () async {
                                    final imagePicker =
                                        Provider.of<ImagePickerService>(context,
                                            listen: false);
                                    imageFile = await imagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    buildName(user, userData),
                    SizedBox(height: 25),
                    InputFieldWithTitle(
                      title: "Display Name",
                      content: userData.displayName,
                      icon: Icons.person,
                      controller: _nameController,
                    ),
                    InputFieldWithTitle(
                      title: "Phone Number",
                      content: userData.phoneNumber,
                      icon: Icons.phone_android,
                      controller: _phoneNumberController,
                    ),
                    InputFieldWithTitle(
                      title: "Address",
                      content: userData.address,
                      icon: Icons.home,
                      controller: _addressController,
                    ),
                    InputFieldWithTitle(
                      title: "City",
                      content: userData.city,
                      icon: Icons.location_city,
                      controller: _cityController,
                    ),
                    InputFieldWithTitle(
                      title: "Description",
                      content: userData.description,
                      maxlines: 4,
                      icon: Icons.description,
                      controller: _descriptionController,
                    ),
                    SizedBox(height: 25),
                    RoundedButton(
                      text: "Save Changes",
                      press: () {
                        editUserData(
                            context,
                            _nameController.text.trim(),
                            _phoneNumberController.text.trim(),
                            _addressController.text.trim(),
                            _cityController.text.trim(),
                            _descriptionController.text.trim(),
                            imageFile);
                      },
                    ),
                    SizedBox(height: 25),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("No data available");
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class InputFieldWithTitle extends StatelessWidget {
  const InputFieldWithTitle(
      {Key key,
      @required this.title,
      @required this.content,
      @required this.controller,
      this.maxlines,
      this.icon})
      : super(key: key);

  final String title;
  final String content;
  final TextEditingController controller;
  final int maxlines;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(title),
        ),
        RoundedInputField(
          maxLines: maxlines,
          icon: icon,
          controller: controller,
          hintText: content,
        ),
      ],
    );
  }
}

Widget buildName(User user, UserDataModel userData) => Column(
      //ini harusnya di tambahin User user di params nya
      children: [
        Text(
          userData.displayName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          userData.phoneNumber,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );

Future<void> editUserData(
    BuildContext context,
    String displayName,
    String phoneNumber,
    String address,
    String city,
    String description,
    File imageFile) async {
  try {
    String downloadUrl = "";
    if (imageFile != null) {
      //upload image to storage
      final storage =
          Provider.of<FirebaseStorageService>(context, listen: false);
      downloadUrl = await storage.uploadProfilePicture(file: imageFile);
    } else {
      print("null");
    }
    //save user data to firestore
    final userData = UserDataModel(
        displayName: displayName,
        phoneNumber: phoneNumber,
        address: address,
        city: city,
        description: description,
        photoURL: downloadUrl);
    final database = Provider.of<FirestoreService>(context, listen: false);
    await database.setUserData(userData);
    await imageFile.delete();
  } catch (e) {
    print(e);
  }
}
