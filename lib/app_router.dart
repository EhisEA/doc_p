import 'package:doc/routes.dart';
import 'package:doc/views/admin/admin_home.dart';
import 'package:doc/views/admin/create_doctor_view.dart';
import 'package:doc/views/authentication/login_view.dart';
import 'package:doc/views/authentication/sign_up_view.dart';
import 'package:doc/views/patient/create_report_view.dart';
import 'package:doc/views/patient/patient_home_view.dart';
import 'package:doc/views/report/report_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateReportViewRoute:
        return MaterialPageRoute(builder: (context) => CreateReportView());
        break;
      case ReportViewRoute:
        return MaterialPageRoute(builder: (context) => ReportView());
        break;
      case LoginViewRoute:
        return MaterialPageRoute(builder: (context) => LoginView());
        break;
      case SignUpViewRoute:
        return MaterialPageRoute(builder: (context) => SignUpView());
        break;
      case PatientHomeViewRoute:
        return MaterialPageRoute(builder: (context) => PatientHomeView());
        break;
      case AdminHomeViewRoute:
        return MaterialPageRoute(builder: (context) => AdminHomeView());
        break;
      case CreateDoctorViewRoute:
        return MaterialPageRoute(builder: (context) => CreateDoctorView());
        break;
      default:
    }
  }
}
