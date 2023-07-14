import 'package:absensi_online/core.dart';
import 'package:flutter/material.dart';

import '../../../../state_util.dart';

class HrdDashboardController extends State<HrdDashboardView>
    implements MvcController {
  static late HrdDashboardController instance;
  late HrdDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List dashboardMenuItems = [
    {
      "label": "Explorer",
      "icon": Icons.explore_rounded,
      "page": Container(),
    },
    {
      "label": "Appointment",
      "icon": Icons.date_range,
      "page": Container(),
    },
    {
      "label": "Employee",
      "icon": Icons.people,
      "page": const HrdEmployeeListView(),
    },
    {
      "label": "Company Profile",
      "icon": Icons.store,
      "page": const HrdCompanyProfileView(),
    },
    {
      "label": "Shop",
      "icon": Icons.shopping_bag,
      "page": Container(),
    }
  ];
}
