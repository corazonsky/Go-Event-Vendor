import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_event_vendor/components/text_field_container.dart';
import 'package:go_event_vendor/constant.dart';

class DropDownInputField extends StatelessWidget {
  final String title;
  final dynamic value;
  final List<dynamic> valueList;
  final String hintText;
  final String prefixText;
  final String suffixText;
  final IconData icon;
  final double width;
  final TextEditingController controller;
  final ValueChanged<dynamic> onChanged;

  const DropDownInputField(
      {Key key,
      this.title,
      this.value,
      this.hintText,
      this.prefixText,
      this.suffixText,
      this.icon,
      this.controller,
      this.width = 270,
      this.onChanged,
      this.valueList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldContainer(
          child: DropdownButtonFormField(
            items: valueList.map((dynamic category) {
              return new DropdownMenuItem(
                  value: category,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(category),
                      ),
                    ],
                  ));
            }).toList(),
            onChanged: onChanged,
            value: value,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              prefixIcon: icon != null
                  ? Icon(
                      icon,
                      color: kPrimaryColor,
                    )
                  : null,
              fillColor: kPrimaryLightColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: kPrimaryLightColor,
                  )),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
              ),
              prefixText: prefixText,
              suffixStyle: TextStyle(color: kPrimaryColor),
              suffixText: suffixText,
              labelText: title,
            ),
          ),
          width: width,
        ),
      ],
    );
  }
}
