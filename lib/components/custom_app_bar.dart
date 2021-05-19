import 'package:flutter/material.dart';

import '../constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "GoEvent Vendor",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kPrimaryColor,
          onPressed: () {},
        ),
      ),
    );
  }
}
