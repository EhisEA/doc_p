import 'package:doc/base_view_model.dart';
import 'package:doc/services/navigationService.dart';
import 'package:doc/services/report_service.dart';
import 'package:doc/views/patient/view_models/patient_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../locator.dart';

class CreateReportViewModel extends BaseViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  final ReportService _reportService = ReportService();
  final NavigationService _navigationService = locator<NavigationService>();

  final PatientHomeViewModel _patientHomeViewModel =
      locator<PatientHomeViewModel>();
  FocusNode reportFoucs = FocusNode();

  sendReport() async {
    setBusy(ViewState.Busy);
    print(titleController.text);
    print(reportController.text);
    bool success = await _reportService.sendReport(
      titleController.text,
      reportController.text,
    );
    if (success) {
      Fluttertoast.showToast(msg: "Report has been sent");
      _patientHomeViewModel.getReport();
      _navigationService.goBack();
    } else {
      Fluttertoast.showToast(msg: "Report Failed", backgroundColor: Colors.red);
    }
    setBusy(ViewState.Idle);
  }
}
