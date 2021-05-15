import 'package:flutter/material.dart';
import '../constant.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final onTap;

  const CustomBottomNavigationBar({
    Key key,
    this.currentIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.room_service), label: "My Service"),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
      ],
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: kPrimaryColor,
      onTap: onTap,
    );
  }
}
