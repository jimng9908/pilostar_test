import 'package:flutter/material.dart';

class DataSource {
  final int id;
  final String name;
  final String key;
  final String email;
  final String password;
  final String description;
  final IconData icon;
  final Color iconColor;
  final bool isRequired;

  DataSource({
    required this.id,
    required this.name,
    this.key = '',
    this.email = '',
    this.password = '',
    this.description = '',
    this.icon = Icons.info,
    this.iconColor = Colors.black,
    this.isRequired = false,
  });
}
