import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';

import '../../../../service/attendance_service/attendance_service.dart';
import '../../../../service/auth_service/auth_service.dart';
import '../../../../shared/util/validator/validator.dart';
import '../../../../shared/widget/button/danger_button.dart';
import '../../../../shared/widget/button/primary_button.dart';
import '../../../../shared/widget/form/image_picker/square_image_picker.dart';

class EmployeeAttendanceView extends StatefulWidget {
  const EmployeeAttendanceView({Key? key}) : super(key: key);

  Widget build(context, EmployeeAttendanceController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("EmployeeAttendance"),
        actions: const [],
      ),
      body: Stack(
        children: [
          if (controller.position != null) ...[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Builder(
                builder: (context) {
                  List<Marker> allMarkers = [
                    Marker(
                      point: LatLng(
                        controller.position!.latitude,
                        controller.position!.longitude,
                      ),
                      builder: (context) => const Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                  ];
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                          controller.position!.latitude,
                          controller.position!.longitude,
                        ),
                        zoom: 18,
                        interactiveFlags:
                            InteractiveFlag.all - InteractiveFlag.rotate,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                        ),
                        MarkerLayer(
                          markers: allMarkers,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.deviceModel ?? "",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          SizedBox(
                            height: 120.0,
                            width: 120.0,
                            child: QSquareImagePicker(
                              label: "Photo",
                              hint: "Your photo",
                              validator: Validator.required,
                              value: null,
                              onChanged: (value) {
                                controller.photoUrl = value;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentUser?.displayName ?? "",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  controller.currentDate,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  controller.time,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: AttendanceService().attendanceSnapshot(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) return const Text("Error");
                          if (snapshot.data == null) return Container();
                          final data = snapshot.data!;
                          bool isNotCheckinToday = snapshot.data!.docs.isEmpty;

                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: PrimaryButton(
                                    label: "Check in",
                                    icon: MdiIcons.doorOpen,
                                    enabled: isNotCheckinToday,
                                    onPressed: () => controller.doCheckIn(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DangerButton(
                                    label: "Check out",
                                    icon: MdiIcons.doorClosed,
                                    enabled: isNotCheckinToday ? false : true,
                                    onPressed: () => controller.doCheckOut(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (controller.position == null)
            const Center(
              child: Card(
                color: Color(0xff0e0c23),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Get location...",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  State<EmployeeAttendanceView> createState() => EmployeeAttendanceController();
}
