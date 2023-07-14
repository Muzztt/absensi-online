import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import '../view/employee_main_navigation_view.dart';

class EmployeeMainNavigationController extends State<EmployeeMainNavigationView>
    implements MvcController {
  static late EmployeeMainNavigationController instance;
  late EmployeeMainNavigationView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  int selectedIndex = 0;
  void updateView(int index) {
    selectedIndex = index;
    setState(() {});
  }
}
