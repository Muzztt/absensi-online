import 'package:absensi_online/core.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import '../../../../service/auth_service/auth_service.dart';
import '../view/employee_profile_view.dart';

class EmployeeProfileController extends State<EmployeeProfileView>
    implements MvcController {
  static late EmployeeProfileController instance;
  late EmployeeProfileView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doLogout() async {
    await AuthService().logout();
    Get.offAll(const LoginView());
  }
}
