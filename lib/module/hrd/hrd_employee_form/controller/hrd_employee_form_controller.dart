import 'package:absensi_online/core.dart';
import 'package:absensi_online/service/employee_service/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import '../../../../shared/util/dialog/show_info_dialog.dart';
import '../view/hrd_employee_form_view.dart';

class HrdEmployeeFormController extends State<HrdEmployeeFormView>
    implements MvcController {
  static late HrdEmployeeFormController instance;
  late HrdEmployeeFormView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String? fullName;
  String? email;
  String? position;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  doSave() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    try {
      await EmployeeService().add(
        fullName: fullName!,
        email: email!,
        position: position!,
      );
      Get.back();
    } on Exception {
      showInfoDialog("Invalid email!");
    }
  }
}
