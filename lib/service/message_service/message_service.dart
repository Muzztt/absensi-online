import 'package:absensi_online/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../auth_service/auth_service.dart';

class MessageService {
  send(String message) async {
    await FirebaseFirestore.instance.collection("messages").add({
      "message": message,
      "created_at": Timestamp.now(),
      "time": DateFormat("kk:mm").format(Timestamp.now().toDate()),
      "date": DateFormat("d MMM y").format(Timestamp.now().toDate()),
      "from": {
        "uid": currentUser?.uid,
        "name": currentUser?.displayName,
        "email": currentUser?.email,
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messageSnapshot() {
    return FirebaseFirestore.instance
        .collection("messages")
        .orderBy("created_at", descending: false)
        .snapshots();
  }
}
