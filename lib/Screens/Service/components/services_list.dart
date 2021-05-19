import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/service_card.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/size_config.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(5),
        ),
        child: GridView.count(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          children: List.generate(services.length, (index) {
            return ServiceCard(service: services[index]);
          }),
        ),
      ),
    );
  }
}
