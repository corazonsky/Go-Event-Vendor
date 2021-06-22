import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Service/components/services_list.dart';
import 'package:go_event_vendor/components/main_background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ServiceList()
          ],
        ),
      ),
    );
  }
}
