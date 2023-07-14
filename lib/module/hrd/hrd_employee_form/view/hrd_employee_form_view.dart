import 'package:absensi_online/shared/widget/button/bottom_action_button.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';

import '../../../../shared/util/validator/validator.dart';
import '../../../../shared/widget/form/dropdown/dropdown.dart';
import '../../../../shared/widget/form/textfield/text_field.dart';

class HrdEmployeeFormView extends StatefulWidget {
  const HrdEmployeeFormView({Key? key}) : super(key: key);

  Widget build(context, HrdEmployeeFormController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("HrdEmployeeForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                QTextField(
                  label: "Full name",
                  validator: Validator.required,
                  onChanged: (value) {
                    controller.fullName = value;
                  },
                ),
                QTextField(
                  label: "Email",
                  validator: Validator.email,
                  suffixIcon: Icons.email,
                  onChanged: (value) {
                    controller.email = value;
                  },
                ),
                QDropdownField(
                  label: "Position",
                  validator: Validator.required,
                  items: const [
                    {
                      "label": "Staff",
                      "value": "Staff",
                    },
                    {
                      "label": "Supervisor",
                      "value": "Supervisor",
                    },
                    {
                      "label": "Manager",
                      "value": "Manager",
                    }
                  ],
                  onChanged: (value, label) {
                    controller.position = value;
                  },
                ),
              ],
            ),
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
  State<HrdEmployeeFormView> createState() => HrdEmployeeFormController();
}
