import 'package:doc/base_view_model.dart';
import 'package:doc/routes.dart';
import 'package:doc/services/authentication_service.dart';
import 'package:doc/services/navigationService.dart';

import '../../../locator.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  checkLogin() async {
    if (await _authenticationService.isUserLoggedIn()) {
      _authenticationService.currentUser.isDoctor
          ? _navigationService.navigateTo(AdminHomeViewRoute)
          : _navigationService.navigateTo(PatientHomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
