import 'package:flutter/material.dart';
import 'package:go_event_vendor/components/service_card.dart';
import 'package:go_event_vendor/models/Service.dart';
import 'package:go_event_vendor/services/firestore_service.dart';
import 'package:go_event_vendor/size_config.dart';
import 'package:provider/provider.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({Key key, this.searchString, this.filter, this.sortType})
      : super(key: key);

  final String searchString;
  final ServiceFilter filter;
  final String sortType;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirestoreService>(context);
    print(sortType);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(5),
        ),
        child: Column(
          children: [
            StreamBuilder(
              stream: database.servicesStream(
                queryBuilder: (query) {
                  query = query
                      .where('serviceName',
                          isGreaterThanOrEqualTo: searchString)
                      .where('serviceName', isLessThan: searchString + "~");
                  if (filter != null) {
                    return query.where('serviceType',
                        isEqualTo: filter.serviceType);
                  } else {
                    return query;
                  }
                },
                sort: sortType == "priceAsc"
                    ? (lhs, rhs) => (rhs.price - lhs.price).round()
                    : sortType == "priceDesc"
                        ? (lhs, rhs) => (lhs.price - rhs.price).round()
                        : null,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Service> serviceList = snapshot.data;
                  return Container(
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: serviceList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: ServiceCard(service: serviceList[index]),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("No data available");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
