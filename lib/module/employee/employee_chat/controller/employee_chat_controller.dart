import 'package:absensi_online/service/message_service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:absensi_online/state_util.dart';
import '../view/employee_chat_view.dart';

class EmployeeChatController extends State<EmployeeChatView>
    implements MvcController {
  static late EmployeeChatController instance;
  late EmployeeChatView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  String message = "";
  TextEditingController textEditingController = TextEditingController();
  sendMessage() async {
    if (message.isEmpty) return;
    MessageService().send(message);
    textEditingController.text = "";
  }
}
