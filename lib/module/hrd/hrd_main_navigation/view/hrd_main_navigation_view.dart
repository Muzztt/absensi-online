import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';

class HrdMainNavigationView extends StatefulWidget {
  const HrdMainNavigationView({Key? key}) : super(key: key);

  Widget build(context, HrdMainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 2,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: const [
            HrdDashboardView(),
            HrdProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (newIndex) => controller.updateIndex(newIndex),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<HrdMainNavigationView> createState() => HrdMainNavigationController();
}
