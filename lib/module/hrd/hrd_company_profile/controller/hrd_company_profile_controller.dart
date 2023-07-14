import 'package:absensi_online/core.dart';
import 'package:absensi_online/service/company_service/company_service.dart';
import 'package:flutter/material.dart';

import '../../../../shared/util/dialog/show_info_dialog.dart';
import '../../../../state_util.dart';

class HrdCompanyProfileController extends State<HrdCompanyProfileView>
    implements MvcController {
  static late HrdCompanyProfileController instance;
  late HrdCompanyProfileView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? companyName;
  String? address;
  double? latitude;
  double? longitude;
  Map<String, dynamic>? currentData;
  doSave() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) {
      showInfoDialog("Please fill required fields");
      return;
    }

    await CompanyService().update(
      companyName: companyName ?? currentData?["company_name"],
      address: address ?? currentData?["address"],
      latitude: latitude ?? currentData?["latitude"],
      longitude: longitude ?? currentData?["longitude"],
    );

    Get.back();
  }
}
