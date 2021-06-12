import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/home_screen.dart';
import 'package:go_event_vendor/Screens/Login/components/background.dart';
import 'package:go_event_vendor/Screens/Signup/signup_screen.dart';
import 'package:go_event_vendor/components/already_have_an_account_acheck.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_event_vendor/routes.dart';
import 'package:go_event_vendor/size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(60),
              ),
              child: SvgPicture.asset(
                "assets/icons/login.svg",
                height: getProportionateScreenHeight(300),
              ),
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.of(context).pushNamed(Routes.home);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20)),
              child: AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.of(context).pushNamed(Routes.signup);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
