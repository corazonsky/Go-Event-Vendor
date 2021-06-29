import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/dropdown_input_field.dart';
import 'package:go_event_vendor/components/loading_snackbar.dart';
import 'package:go_event_vendor/components/main_background.dart';
import 'package:go_event_vendor/components/rounded_button.dart';
import 'package:go_event_vendor/components/rounded_input_field.dart';
import 'package:go_event_vendor/components/switch_input.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/models/ServiceType.dart';
import 'package:go_event_vendor/services/auth_service.dart';
import 'package:go_event_vendor/services/firebase_storage_service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/services/image_picker_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final ServiceType serviceType;
  const Body({Key key, this.serviceType}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _minOrderController = TextEditingController();
  final _maxOrderController = TextEditingController();
  final _areaController = TextEditingController();
  final _capacityController = TextEditingController();
  bool _status = true;
  List<File> _imageList = [];
  bool _uploading = false;

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
    final ServiceType _type = widget.serviceType;
    return MainBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 25),
                  RoundedInputField(
                    title: _type.name + " Name",
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
                  DropDownInputField(
                    icon: Icons.star,
                    title: _type.name + " Type",
                    valueList: _type.category,
                    controller: _categoryController,
                    onChanged: (newValue) {
                      setState(() => _categoryController.text = newValue);
                    },
                  ),
                  RoundedInputField(
                    title: "Price (IDR)",
                    hintText: "Price",
                    icon: Icons.money,
                    suffixText: "IDR/" + _type.unit,
                    controller: _priceController,
                    digitInput: true,
                  ),
                  RoundedInputField(
                    title: "Min " + _type.unit + " Order",
                    hintText: "Min Order",
                    icon: Icons.alarm_off,
                    suffixText: _type.unit,
                    controller: _minOrderController,
                    digitInput: true,
                  ),
                  RoundedInputField(
                    title: "Max " + _type.unit + " Order",
                    hintText: "Max Order",
                    icon: Icons.alarm_add,
                    suffixText: _type.unit,
                    controller: _maxOrderController,
                    digitInput: true,
                  ),
                  if (_type.name == "Venue")
                    Column(
                      children: [
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
                      ],
                    ),
                  SwitchInput(
                    status: _status,
                    title: "Status",
                    trueValue: "Active",
                    falseValue: "Inactive",
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, bottom: 5),
                          child: Text(
                            "Image Gallery",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 16),
                          ),
                        ),
                        GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _imageList.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Container(
                                      child: IconButton(
                                        icon: Icon(Icons.add_a_photo),
                                        color: Colors.white,
                                        onPressed: () {
                                          if (!_uploading) chooseImage();
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                          gradient: kPrimaryGradient),
                                      margin: EdgeInsets.all(4),
                                    )
                                  : Stack(
                                      fit: StackFit.expand,
                                      clipBehavior: Clip.none,
                                      children: [
                                          Container(
                                            margin: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(
                                                    _imageList[index - 1]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: SizedBox(
                                              height: 46,
                                              width: 46,
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFFF5F6F9)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _imageList
                                                        .removeAt(index - 1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]);
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  RoundedButton(
                    text: "Create Service",
                    press: () {
                      if (_formKey.currentState.validate()) {
                        if (!_uploading) {
                          loadingSnackBar(context, "Creating Service");
                          createService()
                              .whenComplete(() => Navigator.of(context).pop());
                          setState(() {
                            print(_uploading);
                            _uploading = true;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  chooseImage() async {
    final imagePicker = Provider.of<ImagePickerService>(context, listen: false);
    File imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imagePicked != null) _imageList.add(imagePicked);
    });
  }

  Future createService() async {
    try {
      String vendorId = Provider.of<FirebaseAuthService>(context, listen: false)
          .getCurrentUser()
          .uid;

      String serviceId =
          FirebaseFirestore.instance.collection('services').doc().id;
      String serviceType = widget.serviceType.name;
      String serviceName = _nameController.text.trim();
      String description = _descriptionController.text.trim();
      String category = _categoryController.text.trim();
      double price = double.parse(_priceController.text.trim());
      int minOrder = int.parse(_minOrderController.text.trim());
      int maxOrder = int.parse(_maxOrderController.text.trim());
      int capacity = _capacityController.text == ""
          ? null
          : int.parse(_capacityController.text.trim());
      int area = _areaController.text == ""
          ? null
          : int.parse(_areaController.text.trim());
      bool status = _status;
      List serviceImages = [];
      //List searchIndex = [];

      if (_imageList != null) {
        //upload image to storage
        final storage =
            Provider.of<FirebaseStorageService>(context, listen: false);
        serviceImages = await storage.uploadServiceImages(
            serviceId: serviceId, fileList: _imageList);
      } else {
        print("null");
      }

      //save service data to firestore
      final service = Service(
        serviceId: serviceId,
        vendorId: vendorId,
        serviceType: serviceType,
        serviceName: serviceName,
        description: description,
        category: category,
        price: price,
        minOrder: minOrder,
        maxOrder: maxOrder,
        area: area,
        capacity: capacity,
        status: status,
        images: serviceImages,
        //searchIndex: searchIndex
      );
      final database = Provider.of<FirestoreService>(context, listen: false);
      await database.setService(service);
    } catch (e) {
      print(e);
    }
  }
}