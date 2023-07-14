// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class SuccessButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPressed;
  final bool enabled;
  const SuccessButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: !enabled ? Colors.grey : Colors.green,
          shape: const StadiumBorder(),
        ),
        onPressed: () {
          if (enabled) onPressed();
        },
      ),
    );
  }
}
