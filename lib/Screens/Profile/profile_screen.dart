import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Profile/component/body.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import 'package:go_event_vendor/models/User.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 3;
    final userData = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: CustomAppBar(title: "Vendor Profile", backButton: true),
      body: Body(
        userData: userData,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}
