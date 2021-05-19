import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/components/body.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 0;
    return Scaffold(
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavigationBar(currentIndex: selectedIndex),
    );
  }
}
