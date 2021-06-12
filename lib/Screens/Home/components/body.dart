import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/components/slider_list.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderList(title: "Your Services", type: "service"),
            SizedBox(height: 25),
            SliderList(title: "Your Orders", type: "order")
          ],
        ),
      ),
    );
  }
}
