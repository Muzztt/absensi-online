import 'package:absensi_online/core.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import '../../../../service/auth_service/auth_service.dart';
import '../view/hrd_profile_view.dart';

class HrdProfileController extends State<HrdProfileView>
    implements MvcController {
  static late HrdProfileController instance;
  late HrdProfileView view;

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
