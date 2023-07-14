// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class EmployeeMainNavigationMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;
  final int index;
  final int selectedIndex;

  const EmployeeMainNavigationMenuItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool selected = index == selectedIndex;
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32.0,
            color: selected ? const Color(0xff017aff) : Colors.grey[500],
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.0,
              color: selected ? const Color(0xff017aff) : Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
