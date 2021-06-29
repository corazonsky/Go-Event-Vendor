import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kPrimaryGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [Colors.blueGrey, kPrimaryColor],
);

Map<String, IconData> iconMapping = {
  'Venue': Icons.location_city,
  'Talent': Icons.music_note,
  'Catering': Icons.fastfood,
  '': Icons.person
};
