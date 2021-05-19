import 'package:flutter/material.dart';

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
      ]),
    );
  }
}
