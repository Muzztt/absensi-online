import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';

import '../../../shared/widget/button/primary_button.dart';
import '../../../shared/widget/button/secondary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1543872084-c7bd3822856f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://icons.iconarchive.com/icons/thesquid.ink/free-flat-sample/256/owl-icon.png",
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Absensi Online",
                    style: GoogleFonts.lobster(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  PrimaryButton(
                    label: "Login as HRD",
                    icon: Icons.supervised_user_circle_sharp,
                    onPressed: () => controller.doHRDLogin(),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  SecondaryButton(
                    label: "Login as Employee",
                    icon: Icons.supervised_user_circle_outlined,
                    onPressed: () => controller.doEmployeeLogin(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
