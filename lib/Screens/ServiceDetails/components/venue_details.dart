import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/size_config.dart';
import 'package:provider/provider.dart';

class VenueDetails extends StatefulWidget {
  final Service service;
  const VenueDetails({Key key, this.service}) : super(key: key);

  @override
  _VenueDetailsState createState() => _VenueDetailsState();
}

class _VenueDetailsState extends State<VenueDetails> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _minOrderController = TextEditingController();
  final _maxOrderController = TextEditingController();
  final _areaController = TextEditingController();
  final _capacityController = TextEditingController();
  bool _status;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.service.serviceName;
    _descriptionController.text = widget.service.description;
    _priceController.text = widget.service.price.toString();
    _minOrderController.text = widget.service.minOrder.toString();
    _maxOrderController.text = widget.service.maxOrder.toString();
    _areaController.text = widget.service.area.toString();
    _capacityController.text = widget.service.capacity.toString();
    _status = widget.service.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _minOrderController.dispose();
    _maxOrderController.dispose();
    _areaController.dispose();
    _capacityController.dispose();
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Service service = widget.service;
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: getProportionateScreenWidth(SizeConfig.screenWidth),
              height:
                  getProportionateScreenHeight(0.25 * SizeConfig.screenHeight),
              child: Image.network(service.images[0], fit: BoxFit.fill),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                service.serviceName,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.payment,
                      ),
                      Text(
                        "126",
                        style: TextStyle(fontSize: 25, color: kPrimaryColor),
                      ),
                      Text(
                        "Ordered",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.star),
                      Text(
                        "4.3",
                        style: TextStyle(fontSize: 25, color: kPrimaryColor),
                      ),
                      Text(
                        "Rating",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.rate_review),
                      Text(
                        "88",
                        style: TextStyle(fontSize: 25, color: kPrimaryColor),
                      ),
                      Text(
                        "Reviews",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),
            RoundedInputField(
              title: "Service Name",
              hintText: "Service Name",
              icon: Icons.room_service,
              controller: _nameController,
            ),
            RoundedInputField(
              title: "Description",
              hintText: "Description",
              icon: Icons.description,
              maxLines: 4,
              controller: _descriptionController,
            ),
            RoundedInputField(
              title: "Price (IDR)",
              hintText: "Price",
              icon: Icons.money,
              suffixText: "IDR/hour",
              controller: _priceController,
              digitInput: true,
            ),
            RoundedInputField(
              title: "Min Order Hour(s)",
              hintText: "Min Order Hour(s)",
              icon: Icons.timer_off,
              suffixText: "hour(s)",
              controller: _minOrderController,
              digitInput: true,
            ),
            RoundedInputField(
              title: "Max Order Hour(s)",
              hintText: "Max Order Hour(s)",
              icon: Icons.timer,
              suffixText: "hour(s)",
              controller: _maxOrderController,
              digitInput: true,
            ),
            RoundedInputField(
              title: "Area(M\u00B2)",
              hintText: "Area",
              icon: Icons.home,
              suffixText: "M\u00B2",
              controller: _areaController,
              digitInput: true,
            ),
            RoundedInputField(
              title: "Capacity (pax)",
              hintText: "Capacity",
              icon: Icons.person,
              suffixText: "Pax",
              controller: _capacityController,
              digitInput: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Status",
                  style: TextStyle(color: kPrimaryColor, fontSize: 16),
                ),
                Row(
                  children: [
                    Switch(
                      value: _status,
                      onChanged: (value) {
                        setState(() {
                          _status = value;
                        });
                      },
                      activeTrackColor: kPrimaryColor,
                      activeColor: kPrimaryLightColor,
                    ),
                    Text(
                      _status ? "Active" : "Inactive",
                      style: TextStyle(
                          color: _status ? Colors.green : Colors.redAccent),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 25),
            RoundedButton(
              text: "Update Service",
              press: () async {
                editService();
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  editService() async {
    try {
      String serviceId = widget.service.serviceId;
      String serviceName = _nameController.text.trim();
      String description = _descriptionController.text.trim();
      int price = int.parse(_priceController.text.trim());
      int minOrder = int.parse(_minOrderController.text.trim());
      int maxOrder = int.parse(_maxOrderController.text.trim());
      int capacity = int.parse(_capacityController.text.trim());
      int area = int.parse(_areaController.text.trim());
      bool status = _status;

      //save service data to firestore
      final service = Service(
        serviceId: serviceId,
        serviceName: serviceName,
        description: description,
        price: price,
        minOrder: minOrder,
        maxOrder: maxOrder,
        area: area,
        capacity: capacity,
        status: status,
      );
      final database = Provider.of<FirestoreService>(context, listen: false);
      await database.setService(service);
    } catch (e) {
      print(e);
    }
  }
}