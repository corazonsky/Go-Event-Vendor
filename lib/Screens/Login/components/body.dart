import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/home_screen.dart';
import 'package:go_event_vendor/Screens/Login/components/background.dart';
import 'package:go_event_vendor/Screens/Signup/signup_screen.dart';
import 'package:go_event_vendor/components/already_have_an_account_acheck.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_event_vendor/providers/auth_provider.dart';
import 'package:go_event_vendor/routes.dart';
import 'package:go_event_vendor/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                hintText: "Your Email", controller: _emailController),
            RoundedPasswordField(controller: _passwordController),
            RoundedButton(
              text: "LOGIN",
              press: () {
                context.read<AuthProvider>().logIn(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
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
