import 'package:flutter/material.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/size_config.dart';
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
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => {},
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: AspectRatio(
                    aspectRatio: 1.1,
                    child: Container(
                      decoration: BoxDecoration(color: kPrimaryLightColor),
                      child: Hero(
                        tag: service.id.toString(),
                        child: Image.asset(
                          service.images[0],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: getProportionateScreenHeight(5)),
                    child: Text(
                      service.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(12)),
                      maxLines: 2,
                    ),
                  ),
                  height: getProportionateScreenHeight(35),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rp.${service.price}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(10),
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
                            fontSize: getProportionateScreenWidth(10),
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
      ),
    );
  }
}
