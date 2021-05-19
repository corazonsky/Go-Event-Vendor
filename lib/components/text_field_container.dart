import 'package:flutter/material.dart';
import 'package:go_event_vendor/constant.dart';

import '../size_config.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double width;
  const TextFieldContainer({
    Key key,
    this.child,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: getProportionateScreenWidth(width),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
