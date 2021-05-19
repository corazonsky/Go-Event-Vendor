import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/Home/components/section_title.dart';
import 'package:go_event_vendor/Screens/Service/service_screen.dart';
import 'package:go_event_vendor/components/order_card.dart';
import 'package:go_event_vendor/components/service_card.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/models/Order.dart';

class SliderList extends StatelessWidget {
  const SliderList({
    Key key,
    this.title,
    this.type,
  }) : super(key: key);

  final String title, type;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05 * size.width),
          child: SectionTitle(
              title: title,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      if (type == "service") return ServiceScreen();
                      return ServiceScreen();
                    },
                  ),
                );
              }),
        ),
        SizedBox(height: 0.05 * size.width),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                5,
                (index) {
                  if (type == "service")
                    return ServiceCard(service: services[index]);
                  return OrderCard(order: orders[index]);
                },
              ),
              SizedBox(width: 0.05 * size.width),
            ],
          ),
        )
      ],
    );
  }
}
