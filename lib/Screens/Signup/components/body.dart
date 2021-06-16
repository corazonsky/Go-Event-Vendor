import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Signup/components/background.dart';
import 'package:go_event_vendor/components/already_have_an_account_acheck.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/rounded_password_field.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/models/UserData.dart';
import 'package:go_event_vendor/routes.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firebase_storage_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/services/image_picker_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File imageFile;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(60),
              ),
              child: Column(
                children: [
                  (imageFile != null)
                      ? Container(
                          width: getProportionateScreenWidth(120),
                          height: getProportionateScreenWidth(120),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: kPrimaryColor),
                              image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover)),
                        )
                      : Container(
                          width: getProportionateScreenWidth(120),
                          height: getProportionateScreenWidth(120),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kPrimaryColor),
                          ),
                        ),
                  RoundedButton(
                    text: "+ Profile Picture",
                    press: () async {
                      final imagePicker = Provider.of<ImagePickerService>(
                          context,
                          listen: false);
                      imageFile = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      setState(() {});
                    },
                  ),
                  RoundedInputField(
                    hintText: "Vendor Name",
                    controller: _nameController,
                  ),
                  RoundedInputField(
                    hintText: "Email",
                    controller: _emailController,
                  ),
                  RoundedInputField(
                    hintText: "Phone Number",
                    icon: Icons.phone,
                    controller: _phoneNumberController,
                  ),
                  RoundedInputField(
                    hintText: "Address",
                    maxLines: 2,
                    icon: Icons.home,
                    controller: _addressController,
                  ),
                  RoundedInputField(
                    hintText: "City",
                    icon: Icons.location_city,
                    controller: _cityController,
                  ),
                  RoundedInputField(
                    hintText: "Description",
                    maxLines: 4,
                    icon: Icons.description,
                    controller: _descriptionController,
                  ),
                  RoundedPasswordField(
                    controller: _passwordController,
                  ),
                  RoundedButton(
                      text: "SIGNUP",
                      press: () {
                        signUp(
                            context,
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            _phoneNumberController.text.trim(),
                            _addressController.text.trim(),
                            _cityController.text.trim(),
                            _descriptionController.text.trim(),
                            imageFile);
                      }),
                ],
              ),
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.of(context).pushNamed(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signUp(
    BuildContext context,
    String displayName,
    String email,
    String password,
    String phoneNumber,
    String address,
    String city,
    String description,
    File imageFile) async {
  try {
    //register User, get the UID and save the user data
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    final registeredUser =
        await auth.registerWithEmailAndPassword(email, password);
    String downloadUrl = "";
    if (imageFile != null) {
      //upload image to storage
      final storage = FirebaseStorageService(uid: registeredUser.uid);
      downloadUrl = await storage.uploadProfilePicture(file: imageFile);
    }
    //save user data to firestore
    final userData = UserDataModel(
        uid: registeredUser.uid,
        displayName: displayName,
        phoneNumber: phoneNumber,
        address: address,
        city: city,
        description: description,
        role: "Vendor",
        photoURL: downloadUrl);
    final database = FirestoreService(uid: registeredUser.uid);
    await database.setUserData(userData);
    await imageFile.delete();
  } catch (e) {
    print(e);
  }
}
