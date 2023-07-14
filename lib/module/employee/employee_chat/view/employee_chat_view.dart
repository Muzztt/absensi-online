import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/core.dart';
import '../../../../service/auth_service/auth_service.dart';
import '../../../../service/message_service/message_service.dart';

/*
  messages
    uid
      message
      created_at  (Timestamp)
      from
        uid
        name
        email
*/
class EmployeeChatView extends StatefulWidget {
  const EmployeeChatView({Key? key}) : super(key: key);

  Widget build(context, EmployeeChatController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("EmployeeChat"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: MessageService().messageSnapshot(),
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
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item =
                          (data.docs[index].data() as Map<String, dynamic>);
                      item["id"] = data.docs[index].id;

                      bool isMe = item["from"]["uid"] == currentUser?.uid;

                      var borderRadius = const BorderRadius.only(
                        topLeft: Radius.circular(
                          16.0,
                        ),
                        topRight: Radius.circular(
                          16.0,
                        ),
                        bottomRight: Radius.circular(
                          16.0,
                        ),
                      );
                      if (isMe) {
                        borderRadius = const BorderRadius.only(
                          topLeft: Radius.circular(
                            16.0,
                          ),
                          topRight: Radius.circular(
                            16.0,
                          ),
                          bottomLeft: Radius.circular(
                            16.0,
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.only(
                              bottom: 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.green : Colors.grey,
                              borderRadius: borderRadius,
                            ),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["from"]?["name"] ?? "",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  item["message"],
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  item["time"],
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              height: 44.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    6.0,
                  ),
                ),
              ),
              child: Center(
                child: TextField(
                  controller: controller.textEditingController,
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: InkWell(
                      onTap: () => controller.sendMessage(),
                      child: Icon(
                        Icons.send,
                        color: Colors.grey[600],
                      ),
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  onChanged: (value) {
                    controller.message = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<EmployeeChatView> createState() => EmployeeChatController();
}
