import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Login/login_screen.dart';
import 'package:go_event_vendor/Screens/Signup/components/background.dart';
import 'package:go_event_vendor/components/already_have_an_account_acheck.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/rounded_password_field.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
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
                  RoundedInputField(
                    hintText: "Email",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    hintText: "Phone Number",
                    onChanged: (value) {},
                    icon: Icons.phone,
                  ),
                  RoundedInputField(
                    hintText: "Service Area",
                    onChanged: (value) {},
                    icon: Icons.location_city,
                  ),
                  RoundedInputField(
                    hintText: "Address",
                    onChanged: (value) {},
                    maxLines: 2,
                    icon: Icons.home,
                  ),
                  RoundedInputField(
                    hintText: "Description",
                    onChanged: (value) {},
                    maxLines: 4,
                    icon: Icons.description,
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "SIGNUP",
                    press: () {},
                  ),
                ],
              ),
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
