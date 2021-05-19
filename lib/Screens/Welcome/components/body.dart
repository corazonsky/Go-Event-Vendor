import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_event_vendor/Screens/Login/login_screen.dart';
import 'package:go_event_vendor/Screens/Signup/signup_screen.dart';
import 'package:go_event_vendor/Screens/Welcome/components/background.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/size_config.dart';

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
              "WELCOME GO-EVENT VENDORS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(80)),
              child: SvgPicture.asset("assets/icons/chat.svg",
                  height: getProportionateScreenHeight(350)),
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            ),
            RoundedButton(
              text: "REGISTER",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }),
                );
              },
              color: kPrimaryLightColor,
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
