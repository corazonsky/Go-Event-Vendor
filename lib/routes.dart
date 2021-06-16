import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/home_screen.dart';
import 'package:go_event_vendor/Screens/Login/login_screen.dart';
import 'package:go_event_vendor/Screens/Service/service_screen.dart';
import 'package:go_event_vendor/Screens/Signup/signup_screen.dart';
import 'package:go_event_vendor/Screens/Welcome/welcome_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String service = '/service';
  static const String service_details = '/service_details';
  static const String create_service = '/create_service';

  static final routes = <String, WidgetBuilder>{
    welcome: (BuildContext context) => WelcomeScreen(),
    login: (BuildContext context) => LoginScreen(),
    signup: (BuildContext context) => SignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    service: (BuildContext context) => ServiceScreen(),
  };
}
