import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key key, this.title, this.press}) : super(key: key);

  @required
  final String title;
  @required
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Colors.black,
              )),
          GestureDetector(onTap: press, child: Text("See More"))
        ],
      ),
    );
  }
}
