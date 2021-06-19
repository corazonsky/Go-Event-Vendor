import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:provider/provider.dart';

class Venue extends StatefulWidget {
  const Venue({Key key}) : super(key: key);

  @override
  _VenueState createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _minOrderController = TextEditingController();
  final _maxOrderController = TextEditingController();
  final _areaController = TextEditingController();
  final _capacityController = TextEditingController();
  File imageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _minOrderController.dispose();
    _maxOrderController.dispose();
    _areaController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            RoundedInputField(
              hintText: "Service Name",
              icon: Icons.room_service,
              controller: _nameController,
            ),
            RoundedInputField(
              hintText: "Description",
              icon: Icons.description,
              maxLines: 4,
              controller: _descriptionController,
            ),
            RoundedInputField(
              hintText: "Price",
              icon: Icons.money,
              suffixText: "IDR/hour",
              controller: _priceController,
              digitInput: true,
            ),
            RoundedInputField(
              hintText: "Address",
              icon: Icons.location_city,
              controller: _addressController,
            ),
            RoundedInputField(
              hintText: "Min Book Hour(s)",
              icon: Icons.timer_off,
              suffixText: "hour(s)",
              controller: _minOrderController,
              digitInput: true,
            ),
            RoundedInputField(
              hintText: "Max Book Hour(s)",
              icon: Icons.timer,
              suffixText: "hour(s)",
              controller: _maxOrderController,
              digitInput: true,
            ),
            RoundedInputField(
              hintText: "Area",
              icon: Icons.home,
              suffixText: "M\u00B2",
              controller: _areaController,
              digitInput: true,
            ),
            RoundedInputField(
              hintText: "Capacity",
              icon: Icons.person,
              suffixText: "Pax",
              controller: _capacityController,
              digitInput: true,
            ),
            SizedBox(height: 25),
            RoundedButton(
              text: "Create Service",
              press: () async {
                createService(
                    context,
                    "Venue",
                    _nameController.text.trim(),
                    _descriptionController.text.trim(),
                    _priceController.text.trim(),
                    _minOrderController.text.trim(),
                    _maxOrderController.text.trim(),
                    _areaController.text.trim(),
                    _capacityController.text.trim());
              },
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

Future<void> createService(
    BuildContext context,
    String serviceType,
    String serviceName,
    String description,
    String price,
    String minOrder,
    String maxOrder,
    String area,
    String capacity) async {
  try {
    String vendorId = Provider.of<FirebaseAuthService>(context, listen: false)
        .getCurrentUser()
        .uid;
    bool status = true;
    int convertedPrice = int.parse(price);
    int convertedMinOrder = int.parse(minOrder);
    int convertedMaxOrder = int.parse(maxOrder);
    int convertedCapacity = int.parse(capacity);
    int convertedArea = int.parse(area);
    String serviceId =
        FirebaseFirestore.instance.collection('services').doc().id;
    //save user data to firestore
    final service = Service(
      serviceId: serviceId,
      vendorId: vendorId,
      serviceType: serviceType,
      serviceName: serviceName,
      description: description,
      price: convertedPrice,
      minOrder: convertedMinOrder,
      maxOrder: convertedMaxOrder,
      area: convertedArea,
      capacity: convertedCapacity,
      status: status,
    );
    final database = Provider.of<FirestoreService>(context, listen: false);
    await database.setService(service);
  } catch (e) {
    print(e);
  }
}
