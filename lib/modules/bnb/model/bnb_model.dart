// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BnbModel {
  final String text;
  final IconData icon;
  BnbModel({
    required this.text,
    required this.icon,
  });
}

List<BnbModel> bnbContent = [
  BnbModel(text: 'الرئيسية', icon: Icons.home),
  BnbModel(text: 'الفئات', icon: Icons.category),
  BnbModel(text: 'طلباتي', icon: Icons.star_rate),
  BnbModel(text: 'الملف الشخصي', icon: Icons.person_2),
];
