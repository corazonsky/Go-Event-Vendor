import 'package:flutter/material.dart';

class Service {
  final String name, description, status;
  final List<String> images;
  final int price, size, id;
  final double rating;
  final Color color;
  Service(
      {this.id,
      this.images,
      this.name,
      this.price,
      this.description,
      this.status,
      this.size,
      this.color,
      this.rating});
}

List<Service> services = [
  Service(
      id: 1,
      name: "Kassandra Ballroom - Max. 100 Pax",
      price: 880000,
      size: 12,
      rating: 4.5,
      description: dummyText,
      images: ["assets/images/service_1.jpg"],
      color: Color(0xFF3D82AE)),
  Service(
      id: 2,
      name: "Ballroom Biasa",
      price: 1790000,
      size: 8,
      rating: 4.5,
      description: dummyText,
      images: ["assets/images/service_2.jpg"],
      color: Color(0xFFD3A984)),
  Service(
      id: 3,
      name: "Rameses Ballroom - Max. 1000 Pax",
      price: 2690000,
      size: 10,
      rating: 4.5,
      description: dummyText,
      images: ["assets/images/image_banner.png"],
      color: Color(0xFF989493)),
  Service(
      id: 4,
      name: "Rameses Ballroom - Max. 1000 Pax",
      price: 2690000,
      size: 11,
      rating: 4.5,
      description: dummyText,
      images: ["assets/images/service_1.jpg"],
      color: Color(0xFFE6B398)),
  Service(
      id: 5,
      name: "Rameses Ballroom - Max. 1000 Pax",
      price: 2690000,
      size: 12,
      rating: 4.5,
      description: dummyText,
      images: ["assets/images/service_2.jpg"],
      color: Color(0xFFFB7883)),
  Service(
    id: 6,
    name: "Rameses Ballroom - Max. 1000 Pax",
    price: 2690000,
    size: 12,
    rating: 4.5,
    description: dummyText,
    images: ["assets/images/image_banner.png"],
    color: Color(0xFFAEAEAE),
  ),
  Service(
    id: 7,
    name: "Rameses Ballroom - Max. 1000 Pax",
    price: 2690000,
    size: 12,
    rating: 4.5,
    description: dummyText,
    images: ["assets/images/image_banner.png"],
    color: Color(0xFFAEAEAE),
  ),
  Service(
    id: 8,
    name: "Rameses Ballroom - Max. 1000 Pax",
    price: 2690000,
    size: 12,
    rating: 4.5,
    description: dummyText,
    images: ["assets/images/image_banner.png"],
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
