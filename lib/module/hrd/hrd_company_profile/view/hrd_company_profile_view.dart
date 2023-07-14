import 'package:absensi_online/service/company_service/company_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';
import '../../../../shared/util/validator/validator.dart';
import '../../../../shared/widget/button/bottom_action_button.dart';
import '../../../../shared/widget/form/location_picker/location_picker.dart';
import '../../../../shared/widget/form/memo_field/memo_field.dart';
import '../../../../shared/widget/form/textfield/text_field.dart';

class HrdCompanyProfileView extends StatefulWidget {
  const HrdCompanyProfileView({Key? key}) : super(key: key);

  Widget build(context, HrdCompanyProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HrdCompanyProfile"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: CompanyService().companySnapshot(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Text("Error");
              if (snapshot.data == null) return Container();

              Map<String, dynamic> currentData = {};
              if (snapshot.data!.docs.isNotEmpty) {
                currentData =
                    snapshot.data!.docs.first.data() as Map<String, dynamic>;
                controller.currentData = currentData;
              }

              return Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    QTextField(
                      label: "Company name",
                      validator: Validator.required,
                      value: currentData["company_name"],
                      onChanged: (value) {
                        controller.companyName = value;
                      },
                    ),
                    QMemoField(
                      label: "Address",
                      validator: Validator.required,
                      value: currentData["address"],
                      onChanged: (value) {
                        controller.address = value;
                      },
                    ),
                    QLocationPicker(
                      id: "location",
                      label: "Location",
                      latitude: currentData["latitude"],
                      longitude: currentData["longitude"],
                      onChanged: (latitude, longitude) {
                        controller.latitude = latitude;
                        controller.longitude = longitude;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomActionButton(
        icon: Icons.save,
        label: "Save",
        onPressed: () => controller.doSave(),
      ),
    );
  }

  @override
  State<HrdCompanyProfileView> createState() => HrdCompanyProfileController();
}
