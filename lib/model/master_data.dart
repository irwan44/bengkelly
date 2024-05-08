import 'package:flutter/material.dart';

class MasterData {
  String id;
  String? image;
  IconData icon;
  Color color;
  String title;
  Function? onTap;
  bool emergency;
  MasterData({
    this.id = '',
    this.image,
    this.icon = Icons.add,
    this.title = '',
    this.color = Colors.transparent,
    this.onTap,
    this.emergency = false,
  });
}