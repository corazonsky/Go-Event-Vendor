import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Service/components/services_list.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import 'package:go_event_vendor/components/dialog_utils.dart';
import 'package:go_event_vendor/components/search_sort_filter.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/models/Service.dart';

import '../../routes.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

final _typeController = TextEditingController();
final _minPriceController = TextEditingController();
final _maxPriceController = TextEditingController();

class _ServiceScreenState extends State<ServiceScreen> {
  final int selectedIndex = 1;
  final _searchController = TextEditingController();
  ServiceFilter _serviceFilter;
  String _sort;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Service Offered",
        backButton: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SearchSortFilter(
                searchController: _searchController,
                onChanged: (text) {
                  setState(() {});
                },
                sort: () async {
                  _sort = await DialogUtils.displaySortDialog(context);
                  setState(() {});
                },
                filter: () async {
                  _serviceFilter = await DialogUtils.displayFilterDialog(
                      context,
                      _typeController,
                      _minPriceController,
                      _maxPriceController);
                  setState(() {});
                },
              ),
            )),
      ),
      body: ServiceList(
        searchString: _searchController.text.trim(),
        filter: _serviceFilter,
        sortType: _sort,
      ),
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
