import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widget/employee_main_navigation_menu_item.dart';

class EmployeeMainNavigationView extends StatefulWidget {
  const EmployeeMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, EmployeeMainNavigationController controller) {
    controller.view = this;

    return Scaffold(
      body: IndexedStack(
        index: controller.selectedIndex,
        children: [
          const EmployeeDashboardView(),
          const EmployeeAttendanceHistoryView(),
          Container(),
          const EmployeeProfileView(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        height: 74.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: EmployeeMainNavigationMenuItem(
                label: "Home",
                icon: Icons.home,
                index: 0,
                selectedIndex: controller.selectedIndex,
                onTap: () => controller.updateView(0),
              ),
            ),
            Expanded(
              child: EmployeeMainNavigationMenuItem(
                label: "History",
                icon: Icons.history,
                index: 1,
                selectedIndex: controller.selectedIndex,
                onTap: () => controller.updateView(1),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 30.0,
                ),
                child: Center(
                  child: Text(
                    "Scan",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: EmployeeMainNavigationMenuItem(
                label: "My Office",
                icon: MdiIcons.store,
                index: 2,
                selectedIndex: controller.selectedIndex,
                onTap: () => controller.updateView(2),
              ),
            ),
            Expanded(
              child: EmployeeMainNavigationMenuItem(
                label: "Profile",
                icon: Icons.person,
                index: 3,
                selectedIndex: controller.selectedIndex,
                onTap: () => controller.updateView(3),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(MdiIcons.qrcodeScan),
        onPressed: () {
          // Aksi ketika tombol tindakan di klik
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  State<EmployeeMainNavigationView> createState() =>
      EmployeeMainNavigationController();
}
