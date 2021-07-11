import 'package:doc/base_view_model.dart';

import 'package:doc/services/authentication_service.dart';
import 'package:doc/services/navigationService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../locator.dart';
import '../../../routes.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  signUp() async {
    setBusy(ViewState.Busy);
    if (form.currentState.validate()) {
      bool isSuccess = await _authenticationService.signUp(
        email: emailController.text,
        name: userController.text,
        password: passwordController.text,
        isDoctor: false,
      );
      if (isSuccess) {
        _authenticationService.currentUser.isDoctor
            ? _navigationService.navigateTo(AdminHomeViewRoute)
            : _navigationService.navigateTo(PatientHomeViewRoute);
      } else {
        Fluttertoast.showToast(msg: "Could not create account");
      }
    }
    setBusy(ViewState.Idle);
  }

  signUpDoctor() async {
    setBusy(ViewState.Busy);
    if (form.currentState.validate()) {
      bool isSuccess = await _authenticationService.signUp(
        email: emailController.text,
        name: userController.text,
        password: passwordController.text,
        isDoctor: true,
      );
      if (isSuccess) {
        Fluttertoast.showToast(
            msg: "account created",
            backgroundColor: Colors.teal,
            textColor: Colors.white);
        _navigationService.goBack();
      } else {
        Fluttertoast.showToast(msg: "Could not create account");
      }
    }
    setBusy(ViewState.Idle);
  }

  goBack() {
    _navigationService.goBack();
  }
}
