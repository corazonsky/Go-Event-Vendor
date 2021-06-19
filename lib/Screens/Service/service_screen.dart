import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Service/components/body.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import 'package:go_event_vendor/components/search_sort_filter.dart';
import 'package:go_event_vendor/constant.dart';

import '../../routes.dart';

class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int selectedIndex = 1;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Service Offered"),
        backButton: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SearchSortFilter(),
            )),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.create_service);
        },
        child: const Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
      ),
    );
  }
}
