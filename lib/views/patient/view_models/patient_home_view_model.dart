import 'package:doc/locator.dart';
import 'package:doc/model/report_model.dart';
import 'package:doc/routes.dart';
import 'package:doc/services/authentication_service.dart';
import 'package:doc/services/navigationService.dart';
import 'package:doc/services/report_service.dart';

import '../../../base_view_model.dart';

class PatientHomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  String get name => _authenticationService.currentUser.name;
  ReportService _reportService = ReportService();
  List<ReportModel> reports = [];
  createReport() {
    _navigationService.navigateTo(CreateReportViewRoute);
  }

  getReport() async {
    setBusy(ViewState.Busy);
    try {
      reports = await _reportService.getReports();
      print(0);
      print(reports == null ? null : reports.length);
    } catch (e) {
      print("==error====");
      print(e);
    }
    setBusy(ViewState.Idle);
  }

  logOut() {
    _authenticationService.logOut();
  }
}
