import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  checkIn({
    required String deviceModel,
    required String deviceId,
    required double latitude,
    required double longitude,
    required String time,
    required String photoUrl,
  }) async {
    /*
    attendances
      docId (generated-id)


    */
    await FirebaseFirestore.instance.collection("attendances").add({
      "checkin_info": {
        "latitude": latitude,
        "longitude": longitude,
        "photo_url": photoUrl,
        "device_model": deviceModel,
        "device_id": deviceId,
        "time": time,
      },
      "date": Timestamp.now(),
      "checkin_date_formatted":
          DateFormat("y-MMM-d").format(Timestamp.now().toDate()),
      "checkin_date": Timestamp.now(),
      "user": {
        "uid": FirebaseAuth.instance.currentUser?.uid,
        "name": FirebaseAuth.instance.currentUser?.displayName,
        "email": FirebaseAuth.instance.currentUser?.email,
      },
    });
  }

  checkout({
    required String deviceModel,
    required String deviceId,
    required double latitude,
    required double longitude,
    required String time,
    required String photoUrl,
  }) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("attendances")
        .where("checkin_date_formatted", //Timestamp
            isEqualTo: DateFormat("y-MMM-d").format(Timestamp.now().toDate()))
        .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    var attendanceToday = snapshot.docs.first;

    await FirebaseFirestore.instance
        .collection("attendances")
        .doc(
          attendanceToday.id,
        )
        .update({
      "checkout": true,
      "checkout_date": Timestamp.now(),
      "checkout_date_formatted":
          DateFormat("y-MMM-d").format(Timestamp.now().toDate()),
      "checkout_info": {
        "latitude": latitude,
        "longitude": longitude,
        "photo_url": photoUrl,
        "device_model": deviceModel,
        "device_id": deviceId,
        "time": time,
      },
    });
  }

  Stream<QuerySnapshot<Object?>>? attendanceSnapshot() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(now);

    return FirebaseFirestore.instance
        .collection("attendances")
        //TODO: balik lagi kesini gan
        .where("checkin_date_formatted", //Timestamp
            isEqualTo: DateFormat("y-MMM-d").format(Timestamp.now().toDate()))
        .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>>? attendanceHistorySnapshot({
    required DateTime date,
  }) {
    bool isToday = DateFormat("y-MMM-d").format(date) ==
        DateFormat("y-MMM-d").format(DateTime.now());

    if (isToday) {
      return FirebaseFirestore.instance
          .collection("attendances")
          .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("attendances")
          .where("checkin_date_formatted",
              isEqualTo: DateFormat("y-MMM-d").format(date))
          .where("user.uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots();
    }
  }

  Future<bool> isNotInValidDistanceWithCompany({
    required double currentLatitude,
    required double currentLongitude,
  }) async {
    var companySnapshot = await FirebaseFirestore.instance
        .collection("company_profile")
        .doc("main-company")
        .get();

    if (companySnapshot.exists) {
      Map<String, dynamic>? companyData =
          companySnapshot.data() as Map<String, dynamic>?;

      if (companyData != null) {
        double targetLatitude = companyData["latitude"]?.toDouble() ?? 0.0;
        double targetLongitude = companyData["longitude"]?.toDouble() ?? 0.0;

        double distance = getDistance(
          currentLatitude,
          currentLongitude,
          targetLatitude,
          targetLongitude,
        );

        return distance > 100; // in meters
      }
    }

    return false; // default value if data not available or snapshot doesn't exist
  }

  double getDistance(
    double currentLatitude,
    double currentLongitude,
    double targetLatitude,
    double targetLongitude,
  ) {
    const int earthRadius = 6371000; // Radius bumi dalam meter

    // Mengonversi kedua koordinat menjadi radian
    double lat1 = radians(currentLatitude);
    double lon1 = radians(currentLongitude);
    double lat2 = radians(targetLatitude);
    double lon2 = radians(targetLongitude);

    // Menghitung selisih koordinat
    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    // Rumus Haversine untuk menghitung jarak antara dua titik
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double radians(double degrees) {
    return degrees * (math.pi / 180);
  }
}
