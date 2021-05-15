import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_event_vendor/Screens/Home/components/section_title.dart';
import 'package:go_event_vendor/Screens/Home/components/slider_list.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/constant.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeHeader(),
            SliderList(title: "Your Services", type: "service"),
            SizedBox(height: 50),
            SliderList(title: "Your Orders", type: "order")
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(children: [
        Text(
          "VENDOR HOME",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          icon: Icons.search,
          hintText: "Search",
          onChanged: (value) {},
        ),
        SizedBox(height: size.height * 0.03),
      ]),
    );
  }
}
