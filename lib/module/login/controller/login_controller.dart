import 'package:absensi_online/core.dart';
import 'package:absensi_online/shared/util/dialog/show_info_dialog.dart';
import 'package:flutter/material.dart';
import '../../../service/auth_service/auth_service.dart';
import '../../../state_util.dart';

class LoginController extends State<LoginView> implements MvcController {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doHRDLogin() async {
    try {
      await AuthService().doHRDLogin();
      Get.offAll(const HrdMainNavigationView());
    } on Exception {
      showInfoDialog("Unauthorized access!");
    }
  }

  doEmployeeLogin() async {
    try {
      await AuthService().doEmployeeLogin();
      Get.offAll(const EmployeeMainNavigationView());
    } on Exception {
      showInfoDialog("Unauthorized access!");
    }
  }
}
