import 'package:flutter/material.dart';
import 'package:go_event_vendor/models/Service.dart';
import '../constant.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key key,
    this.width = 140,
    this.aspectRetio = 1.02,
    @required this.service,
  }) : super(key: key);

  final double width, aspectRetio;
  final Service service;

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
                  child: Hero(
                    tag: service.id.toString(),
                    child: Image.asset(
                      service.images[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                service.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rp.${service.price}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.04 * size.width,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text(
                        "${service.rating}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 0.03 * size.width,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
