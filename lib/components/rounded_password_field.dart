import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/text_field_container.dart';
import 'package:go_event_vendor/constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.controller,
    this.width = 270,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
      width: width,
    );
  }
}
