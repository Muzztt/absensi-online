import 'dart:async';
import 'package:absensi_online/core.dart';
import 'package:absensi_online/service/security_service/security_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../../service/attendance_service/attendance_service.dart';
import '../../../../service/device_service/device_service.dart';
import '../../../../service/location_service/location_service.dart';
import '../../../../shared/util/dialog/show_info_dialog.dart';
import '../../../../shared/util/show_loading/show_loading.dart';
import '../../../../state_util.dart';

class EmployeeAttendanceController extends State<EmployeeAttendanceView>
    implements MvcController {
  static late EmployeeAttendanceController instance;
  late EmployeeAttendanceView view;
  late Timer timer;
  String? photoUrl;

  @override
  void initState() {
    instance = this;
    getUserData();
    getTime();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  getUserData() async {
    await getLocation();
    await getDeviceInfo();
    setState(() {});
  }

  Position? position;
  getLocation() async {
    position = await LocationService().getLocation();
  }

  String? deviceModel;
  String? deviceId;
  getDeviceInfo() async {
    var deviceInfo = await DeviceService().getDeviceInfo();
    deviceModel = deviceInfo.model;
    deviceId = deviceInfo.id;
  }

  String time = "";
  String currentDate = "";
  getTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime date = DateTime.now();
      time = DateFormat("kk:ss").format(date);
      currentDate = DateFormat("d MMMM y").format(date);
      setState(() {});
    });
  }

  Future<bool> doValidate() async {
    if (photoUrl == null) {
      hideLoading();
      showInfoDialog("Photo is required");
      return false;
    }
    if (await isNotInValidDistance()) {
      showInfoDialog("Too far from company :(");
      return false;
    }
    if (await SecurityService().isNotSafeDevice()) {
      hideLoading();
      showInfoDialog("Doesn't work in root android!");
      return false;
    }
    if (await SecurityService().isNoFaceDetected(photoUrl!)) {
      hideLoading();
      showInfoDialog("No face detected!");
      return false;
    }
    return true;
  }

  doCheckIn() async {
    showLoading();
    if (!await doValidate()) {
      return;
    }

    await AttendanceService().checkIn(
      deviceModel: deviceModel!,
      deviceId: deviceId!,
      latitude: position!.latitude,
      longitude: position!.longitude,
      time: time,
      photoUrl: photoUrl!,
    );

    hideLoading();
    Get.back();
  }

  doCheckOut() async {
    showLoading();
    if (!await doValidate()) {
      return;
    }

    await AttendanceService().checkout(
      deviceModel: deviceModel!,
      deviceId: deviceId!,
      latitude: position!.latitude,
      longitude: position!.longitude,
      time: time,
      photoUrl: photoUrl!,
    );

    hideLoading();
    Get.back();
  }

  Future<bool> isNotInValidDistance() async {
    return await AttendanceService().isNotInValidDistanceWithCompany(
      currentLatitude: position!.latitude,
      currentLongitude: position!.longitude,
    );
  }
}
