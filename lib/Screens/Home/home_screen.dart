import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/components/body.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import 'package:go_event_vendor/models/User.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 0;
    SizeConfig().init(context);
    final userData = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Welcome, " + (userData != null ? userData.displayName : null),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}
