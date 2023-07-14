import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import '../../../../service/attendance_service/attendance_service.dart';
import '../../../../shared/widget/horizontal_datepicker/horizontal_datepicker.dart';

class EmployeeAttendanceHistoryView extends StatefulWidget {
  const EmployeeAttendanceHistoryView({Key? key}) : super(key: key);

  Widget build(context, EmployeeAttendanceHistoryController controller) {
    controller.view = this;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Zoloya Office",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: const CircleAvatar(
                      radius: 19.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: const CircleAvatar(
                      radius: 19.0,
                      backgroundColor: Colors.white,
                      child: Badge(
                        label: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              HorizontalDatePicker(
                onChanged: (date) {
                  controller.updateDate(date);
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Divider(),
              const SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: AttendanceService().attendanceHistorySnapshot(
                    date: controller.selectedDate,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return const Text("Error");
                    if (snapshot.data == null) return Container();
                    if (snapshot.data!.docs.isEmpty) {
                      return const Text("No Data");
                    }
                    final data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.docs.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> item =
                            (data.docs[index].data() as Map<String, dynamic>);
                        item["id"] = data.docs[index].id;

                        bool isCheckout = item["checkout"] == true;
                        var checkInDate =
                            (item["checkin_date"] as Timestamp).toDate();
                        String date = DateFormat("dd MMMM").format(checkInDate);
                        bool isCheckInToday =
                            DateFormat("d MMM y").format(checkInDate) ==
                                DateFormat("d MMM y").format(DateTime.now());
                        String ddMMMM =
                            DateFormat("d MMMM").format(checkInDate);

                        bool isCheckOutToday = false;
                        if (item["checkout"] == true) {
                          var checkOutDate =
                              (item["checkout_date"] as Timestamp).toDate();
                          isCheckOutToday =
                              DateFormat("d MMM y").format(checkOutDate) ==
                                  DateFormat("d MMM y").format(DateTime.now());
                        }

                        //----
                        //----
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Card(
                              child: Container(
                                height: 120.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xff017aff),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: ClipPath(
                                        clipper:
                                            ArrowClipper(40, 120, Edge.RIGHT),
                                        child: Container(
                                          height: 60,
                                          padding: const EdgeInsets.all(12.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.46,
                                          color: Colors.white.withOpacity(0.3),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Check-in Time",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6.0,
                                                  ),
                                                  Icon(
                                                    Icons.check_circle_sharp,
                                                    size: 20.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                item["checkin_info"]["time"],
                                                style: const TextStyle(
                                                  fontSize: 40.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                isCheckInToday
                                                    ? "Today"
                                                    : ddMMMM,
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.phone_android,
                                                  size: 24.0,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 4.0,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    item["checkin_info"]
                                                        ["device_model"],
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.settings,
                                                  size: 20.0,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Text(
                                              item["checkin_info"]["device_id"],
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4.0,
                                            ),
                                            const Text(
                                              "Last Seen - Just Now",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isCheckout)
                              Card(
                                child: Container(
                                  height: 120.0,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff0e0c22),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: ClipPath(
                                          clipper:
                                              ArrowClipper(40, 120, Edge.RIGHT),
                                          child: Container(
                                            height: 60,
                                            padding: const EdgeInsets.all(12.0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.46,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "Check-in Time",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 6.0,
                                                    ),
                                                    Icon(
                                                      Icons.check_circle_sharp,
                                                      size: 20.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  item["checkout_info"]["time"],
                                                  style: const TextStyle(
                                                    fontSize: 40.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  isCheckOutToday
                                                      ? "Today"
                                                      : ddMMMM,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone_android,
                                                    size: 24.0,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      item["checkout_info"]
                                                          ["device_model"],
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.settings,
                                                    size: 20.0,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                item["checkout_info"]
                                                    ["device_id"],
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4.0,
                                              ),
                                              const Text(
                                                "Last Seen - Just Now",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<EmployeeAttendanceHistoryView> createState() =>
      EmployeeAttendanceHistoryController();
}
