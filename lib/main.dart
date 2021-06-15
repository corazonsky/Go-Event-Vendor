import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/home_screen.dart';
import 'package:go_event_vendor/Screens/Welcome/welcome_screen.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/routes.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firebase_storage_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/services/image_picker_service.dart';
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
          Provider<FirebaseAuthService>(
            create: (_) => FirebaseAuthService(),
          ),
          Provider<ImagePickerService>(
            create: (_) => ImagePickerService(),
          ),
        ],
        child: AuthWidgetBuilder(
          builder: (context, userSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'GoEvent Vendor Application',
              theme: ThemeData(
                  primaryColor: kPrimaryColor,
                  scaffoldBackgroundColor: Colors.white),
              home: AuthWidget(userSnapshot: userSnapshot),
              routes: Routes.routes,
            );
          },
        ));
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<UserModel> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomeScreen() : WelcomeScreen();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) builder;

  @override
  Widget build(BuildContext context) {
    print('AuthWidgetBuilder rebuild');
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        print('StreamBuilder: ${snapshot.connectionState}');
        final UserModel user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(value: user),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(uid: user.uid),
              ),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
