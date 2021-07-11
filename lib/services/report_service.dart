import 'dart:convert';

import 'package:doc/locator.dart';
import 'package:doc/model/report_model.dart';
import 'package:doc/services/authentication_service.dart';
import 'package:doc/views/admin/view_models/admin_home_view_model.dart';
import 'package:doc/views/patient/view_models/patient_home_view_model.dart';
import 'package:http/http.dart' as http;

import 'dialog_service.dart';

class ReportService {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future<bool> sendReport(String title, String content) async {
    try {
      String url = "https://doc-api-uniben.herokuapp.com/v0/reports";
      http.Response response = await http.post(
        url,
        body: json.encode(
          {
            "title": title,
            "content": content,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "bearer ${_authenticationService.currentUser.token}"
        },
      );

      final result = jsonDecode(response.body);
      print(result);
      return !result["has_error"];
    } catch (e) {
      print("===error===");
      print(e);
      return false;
    }
  }

  Future<bool> sendReply(String content, String id) async {
    try {
      String url = "https://doc-api-uniben.herokuapp.com/v0/replies";
      http.Response response = await http.post(
        url,
        body: json.encode(
          {
            "content": content,
            "report_public_id": id,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "bearer ${_authenticationService.currentUser.token}"
        },
      );

      final result = jsonDecode(response.body);
      print(result);
      if (!result["has_error"]) {
        List<ReportModel> reports = [];
        if (_authenticationService.currentUser.isDoctor) {
          locator<AdminHomeViewModel>().reports.forEach((element) {
            if (element.id == id) {
              element.replies.add(Replies().fromJson(result["data"]));
            }
            reports.add(element);
          });
          locator<AdminHomeViewModel>().reports = reports;
        } else {
          locator<PatientHomeViewModel>().reports.forEach((element) {
            if (element.id == id) {
              element.replies.add(Replies().fromJson(result["data"]));
            }
            reports.add(element);
          });
          locator<PatientHomeViewModel>().reports = reports;
        }
      } else {
        _dialogService.showDialog(
          description: result["description"],
          title: "Sign Failed",
        );
      }
      return !result["has_error"];
    } catch (e) {
      print("===error===");
      print(e);
      return false;
    }
  }

  Future<ReportModel> getReplies(String id) async {
    try {
      String url =
          "https://doc-api-uniben.herokuapp.com/v0/reports/${_authenticationService.currentUser.id}";
      http.Response response = await http.get(
        url,
        headers: {
          "Authorization": "bearer ${_authenticationService.currentUser.token}"
        },
      );
      var result = json.decode(response.body);
      return ReportModel().fromJson(result["data"]);
    } catch (e) {
      print("===error===");
      print(e);
      return null;
    }
  }

  Future<List<ReportModel>> getReports() async {
    try {
      String url =
          "https://doc-api-uniben.herokuapp.com/v0/users/${_authenticationService.currentUser.id}";
      http.Response response = await http.get(url);
      var result = json.decode(response.body);
      print(result);
      List<ReportModel> reports = [];
      if (result["data"] != null) if (_authenticationService
          .currentUser.isDoctor) {
        result["data"]["all_reports"].forEach((item) {
          reports.add(ReportModel().fromJson(item));
        });
      } else {
        result["data"]["reports"].forEach((item) {
          reports.add(ReportModel().fromJson(item));
        });
      }
      return reports;
    } catch (e) {
      print("===error===");
      print(e);
      return null;
    }
  }
}
