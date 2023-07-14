import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';
import '../controller/employee_profile_controller.dart';

class EmployeeProfileView extends StatefulWidget {
  const EmployeeProfileView({Key? key}) : super(key: key);

  Widget build(context, EmployeeProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("EmployeeProfile"),
        actions: [
          IconButton(
            onPressed: () => controller.doLogout(),
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }

  @override
  State<EmployeeProfileView> createState() => EmployeeProfileController();
}
