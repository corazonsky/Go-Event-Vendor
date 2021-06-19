import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';

class ServiceDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 1;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Service Details"),
        backButton: true,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}
