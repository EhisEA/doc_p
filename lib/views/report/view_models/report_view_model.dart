import 'package:doc/base_view_model.dart';
import 'package:doc/model/report_model.dart';
import 'package:doc/model/user_model.dart';
import 'package:doc/services/report_service.dart';
import 'package:flutter/material.dart';

class ReportViewModel extends BaseViewModel {
  final ReportModel report;

  ReportViewModel(this.report);
  final ReportService _reportService = ReportService();
  TextEditingController controller = TextEditingController();
  bool isTyping = false;

  checkTypingStatus() {
    if (controller.text.isNotEmpty) {
      isTyping = true;
      setBusy(ViewState.Idle);
    } else {
      isTyping = false;
      setBusy(ViewState.Idle);
    }
  }

  send() async {
    if (controller.text.isNotEmpty) {
      setBusy(ViewState.Busy);
      bool sentStatus = false;
      String content = controller.text;
      // Replies(
      //     content: controller.text,
      //     date: DateTime.now().toString(),
      //     author: User());
      // //todo add to replies
      // controller.clear();
      // isTyping = false;
      // setBusy(ViewState.Idle);
      try {
        sentStatus = await _reportService.sendReply(controller.text, report.id);
      } catch (e) {
        sentStatus = false;
      }
      if (!sentStatus) {
        controller.text = content;
        isTyping = true;
      } else {
        controller.clear();
        isTyping = false;
      }
      setBusy(ViewState.Idle);
    }
  }
}
