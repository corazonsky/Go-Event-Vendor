import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Profile/component/body.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import '../../size_config.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 3;
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(title: Text("Vendor Profile"), backButton: true),
      body: Body(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}
