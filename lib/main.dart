import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/home_screen.dart';
import 'package:go_event_vendor/Screens/Welcome/welcome_screen.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/providers/auth_provider.dart';
import 'package:go_event_vendor/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
          create: (_) => AuthProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthProvider>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoEvent Vendor Application',
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: AuthenticationWrapper(),
        routes: Routes.routes,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomeScreen();
    }
    return WelcomeScreen();
  }
}
