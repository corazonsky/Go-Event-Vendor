import 'package:flutter/material.dart';
import 'package:go_event_vendor/Screens/ServiceDetails/components/venue_details.dart';
import 'package:go_event_vendor/components/custom_app_bar.dart';
import 'package:go_event_vendor/components/custom_bottom_navbar.dart';
import 'package:go_event_vendor/constant.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:provider/provider.dart';

class ServiceDetailsScreen extends StatelessWidget {
  //final String serviceId;

  const ServiceDetailsScreen({Key key});
  @override
  Widget build(BuildContext context) {
    final Map service = ModalRoute.of(context).settings.arguments;
    final database = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: CustomAppBar(title: Text("Service Details"), backButton: true),
      body: StreamBuilder<Service>(
        stream: database.serviceStream(serviceId: service['serviceId']),
        builder: (context, snapshot) {
          Service service;
          if (snapshot.hasData) {
            service = snapshot.data;
            return VenueDetails(
              service: service,
            );
          } else if (snapshot.hasError) {
            return Text("No data available");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add_a_photo),
            backgroundColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
