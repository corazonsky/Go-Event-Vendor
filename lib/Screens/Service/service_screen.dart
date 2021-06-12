import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Service/components/body.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';

class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 1;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Service Offered",
        searchBar: true,
        backButton: true,
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}
