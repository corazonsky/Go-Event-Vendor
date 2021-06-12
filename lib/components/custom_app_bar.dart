import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/search_sort_filter.dart';

import '../constant.dart';
import '../size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool searchBar;
  final bool backButton;
  const CustomAppBar({
    this.title,
    this.searchBar = false,
    this.backButton = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(searchBar
      ? getProportionateScreenHeight(140)
      : getProportionateScreenHeight(70));
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: kPrimaryGradient),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: kPrimaryLightColor),
      ),
      leading: backButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              color: kPrimaryLightColor,
              onPressed: () {
                Navigator.pop(context, false);
              },
            )
          : Container(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: searchBar
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SearchSortFilter(),
              )
            : Container(),
      ),
    );
  }
}
