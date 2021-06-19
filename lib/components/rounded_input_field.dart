import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_event_vendor/components/text_field_container.dart';
import 'package:go_event_vendor/constant.dart';

class RoundedInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final String prefixText;
  final String suffixText;
  final IconData icon;
  final int maxLines;
  final double width;
  final bool digitInput;
  final TextEditingController controller;

  const RoundedInputField({
    Key key,
    this.title,
    this.hintText,
    this.prefixText,
    this.suffixText,
    this.icon = Icons.person,
    this.maxLines = 1,
    this.controller,
    this.digitInput = false,
    this.width = 270,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(title),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10),
              ),
        TextFieldContainer(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: maxLines,
            controller: controller,
            cursorColor: kPrimaryColor,
            keyboardType: digitInput ? TextInputType.number : null,
            inputFormatters:
                digitInput ? [FilteringTextInputFormatter.digitsOnly] : null,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              prefixText: prefixText,
              suffixStyle: TextStyle(color: kPrimaryColor),
              suffixText: suffixText,
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
          width: width,
        ),
      ],
    );
  }
}
