import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import '../view/employee_attendance_history_view.dart';

class EmployeeAttendanceHistoryController
    extends State<EmployeeAttendanceHistoryView> implements MvcController {
  static late EmployeeAttendanceHistoryController instance;
  late EmployeeAttendanceHistoryView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  DateTime selectedDate = DateTime.now();
  updateDate(DateTime date) {
    selectedDate = date;
    setState(() {});
  }
}
