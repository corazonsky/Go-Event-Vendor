import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Profile/component/body.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import 'package:go_event_vendor/models/UserData.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 3;
    final database = Provider.of<FirestoreService>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(title: Text("Vendor Profile"), backButton: true),
      body: StreamBuilder<UserDataModel>(
        stream: database.userDataStream(),
        builder: (context, snapshot) {
          UserDataModel userData;
          if (snapshot.hasData) {
            userData = snapshot.data;
            return Body(
              userData: userData,
            );
          } else if (snapshot.hasError) {
            return Text("No data available");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}