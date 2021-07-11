import 'package:doc/base_view_model.dart';
import 'package:doc/services/authentication_service.dart';
import 'package:doc/services/navigationService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../locator.dart';
import '../../../routes.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  login() async {
    setBusy(ViewState.Busy);
    if (form.currentState.validate()) {
      bool isSuccess = await _authenticationService.login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (isSuccess) {
        _authenticationService.currentUser.isDoctor
            ? _navigationService.navigateTo(AdminHomeViewRoute)
            : _navigationService.navigateTo(PatientHomeViewRoute);
      } else {
        Fluttertoast.showToast(msg: "Could not login");
      }
    }
    setBusy(ViewState.Idle);
  }
}
