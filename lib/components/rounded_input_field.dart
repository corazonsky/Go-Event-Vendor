import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/text_field_container.dart';
import 'package:go_event_vendor/constant.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final int maxLines;
  final double width;
  final TextEditingController controller;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.maxLines = 1,
    this.controller,
    this.width = 270,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        maxLines: maxLines,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
      width: width,
    );
  }
}
