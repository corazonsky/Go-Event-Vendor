import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/dropdown_input_field.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/models/Service.dart';

class DialogUtils {
  static Future<String> displaySortDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                press: () {
                  Navigator.pop(context, "priceAsc");
                },
                text: 'Price High to Low',
                width: 200,
              ),
              RoundedButton(
                press: () {
                  Navigator.pop(context, "priceDesc");
                },
                text: 'Price Low to High',
                width: 200,
              ),
              RoundedButton(
                press: () {
                  Navigator.of(context).pop();
                },
                text: 'Highest Rated',
                width: 200,
              ),
              RoundedButton(
                press: () {
                  Navigator.pop(context, null);
                },
                color: Colors.red,
                text: 'Cancel Sort',
                width: 200,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<ServiceFilter> displayFilterDialog(
    BuildContext context,
    TextEditingController _typeController,
    TextEditingController _minPriceController,
    TextEditingController _maxPriceController,
  ) async {
    ServiceFilter filter;
    return await showDialog<ServiceFilter>(
      context: context,
      builder: (BuildContext context) {
        print(_typeController.text.trim());
        String _category = "Venue";
        List<String> categories = ["Venue", "Talent", "Catering"];
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Filter'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropDownInputField(
                  title: "Service Type",
                  value: _category,
                  valueList: categories,
                  onChanged: (newValue) {
                    // do other stuff with _category
                    setState(() => _category = newValue);
                    _typeController.text = newValue;
                  },
                ),
                RoundedButton(
                  press: () {
                    if (filter == null) {
                      filter = new ServiceFilter();
                    }
                    filter.serviceType = _typeController.text.trim();
                    Navigator.pop(context, filter);
                  },
                  text: 'Apply Filter',
                  width: 200,
                ),
                RoundedButton(
                  press: () {
                    Navigator.pop(context, null);
                  },
                  color: Colors.red,
                  text: 'Cancel Filter',
                  width: 200,
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
