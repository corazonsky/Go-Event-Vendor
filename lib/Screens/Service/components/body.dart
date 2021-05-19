import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Service/components/services_list.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/search_sort_filter.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/size_config.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StickyHeader(
                header: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blueGrey, kPrimaryColor],
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Service Offered",
                            style: TextStyle(
                                color: kPrimaryLightColor, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          SearchSortFilter()
                        ],
                      )),
                ),
                content: Column(
                  children: [
                    SizedBox(height: 30),
                    ServiceList(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
