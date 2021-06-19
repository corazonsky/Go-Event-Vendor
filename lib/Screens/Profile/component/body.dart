import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/profile_pic.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/models/UserData.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firebase_storage_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/services/image_picker_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final UserDataModel userData;
  const Body({Key key, this.userData}) : super(key: key);

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
  void initState() {
    super.initState();
    _nameController.text = widget.userData.displayName;
    _phoneNumberController.text = widget.userData.phoneNumber;
    _addressController.text = widget.userData.address;
    _cityController.text = widget.userData.city;
    _descriptionController.text = widget.userData.description;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseAuthService>(context).getCurrentUser();
    String imageURL = widget.userData.photoURL;
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfilePic(
              imageFile: imageFile,
              imageURL: imageURL,
              resetImage: () async {
                imageFile = null;
                setState(() {});
              },
              pickImage: () async {
                final imagePicker =
                    Provider.of<ImagePickerService>(context, listen: false);
                File imagePicked =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (imagePicked != null) imageFile = imagePicked;
                setState(() {});
              },
            ),
            buildName(user, widget.userData),
            SizedBox(height: 25),
            RoundedInputField(
              title: "Display Name",
              icon: Icons.person,
              controller: _nameController,
            ),
            RoundedInputField(
              title: "Phone Number",
              icon: Icons.phone_android,
              controller: _phoneNumberController,
            ),
            RoundedInputField(
              title: "Address",
              icon: Icons.home,
              controller: _addressController,
            ),
            RoundedInputField(
              title: "City",
              icon: Icons.location_city,
              controller: _cityController,
            ),
            RoundedInputField(
              title: "Description",
              maxLines: 4,
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
                    imageURL,
                    imageFile);
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
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
    String imageUrl,
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
        photoURL: imageUrl);
    if (downloadUrl != "") {
      userData.photoURL = downloadUrl;
    }
    final database = Provider.of<FirestoreService>(context, listen: false);
    await database.setUserData(userData);
    if (imageFile != null) await imageFile.delete();
  } catch (e) {
    print(e);
  }
}
