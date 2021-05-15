import 'package:flutter/material.dart';
import 'package:go_event_vendor/models/Order.dart';
import '../constant.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.order,
  }) : super(key: key);

  final double width, aspectRetio;
  final Order order;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: 0.05 * size.width),
      child: SizedBox(
        width: width / 375 * size.width,
        child: GestureDetector(
          onTap: () => {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.3,
                child: Container(
                    padding: EdgeInsets.all(0.05 * size.width),
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(children: [
                      Text(
                        order.eventName,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 0.04 * size.width,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.person, size: 0.03 * size.width),
                          Text(
                            order.customerName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 0.025 * size.width,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 0.03 * size.width),
                          Text(
                            order.date,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 0.025 * size.width,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ])),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 0.02 * size.width),
                child: Text(
                  order.status,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
