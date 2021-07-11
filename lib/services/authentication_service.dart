import 'dart:convert';

import 'package:doc/model/user_model.dart';
import 'package:doc/routes.dart';
import 'package:doc/services/dialog_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';
import 'navigationService.dart';

class AuthenticationService {
  User _currentUser;
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  User get currentUser => _currentUser;

  _saveUserLocally() async {
    print(_currentUser.toJson());
    SharedPreferences _preferences;
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString("user", jsonEncode(_currentUser.toJson()));
  }

  _populateCurrentUser(Map<String, dynamic> user, String token) {
    if (user != null) {
      _currentUser = User().fromJson(user, token);
      _saveUserLocally();
    }
  }

  _populateCurrentUserFromMap(Map<String, dynamic> user) {
    if (user != null) {
      _currentUser = User().fromMap(user);
      _saveUserLocally();
    }
  }

  Future<bool> isUserLoggedIn() async {
    // final UserService _userService = UserService();
    SharedPreferences _preferences;
    _preferences = await SharedPreferences.getInstance();
    String userJsonString = _preferences.getString("user");
    if (userJsonString != null) {
      await _populateCurrentUserFromMap(jsonDecode(userJsonString));
    }
    return userJsonString != null;
  }

  Future<bool> login({
    String email,
    String password,
  }) async {
    try {
      Map body = {
        "email": email,
        "password": password,
      };
      http.Response response = await http.post(
        "https://doc-api-uniben.herokuapp.com/v0/login",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var result = json.decode(response.body);
      if (result["has_error"]) {
        _dialogService.showDialog(
          description: result["description"],
          title: "Login Failed",
        );
      }
      print(result);
      if (result["data"] != null) {
        _populateCurrentUser(
            result["data"]["user"], result["data"]["access_token"]);
        return true;
      }
      return false;
    } catch (e) {
      print("error=== $e");
      return false;
    }
  }

  Future<bool> signUp({
    String email,
    String name,
    String password,
    bool isDoctor,
  }) async {
    try {
      Map body = {
        "email": email,
        "name": name,
        "password": password,
        "is_doctor": isDoctor ?? false
      };
      http.Response response = await http.post(
        "https://doc-api-uniben.herokuapp.com/v0/signup",
        body: json.encode(body),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var result = json.decode(response.body);
      if (result["has_error"]) {
        _dialogService.showDialog(
          description: result["description"],
          title: "Sign Failed",
        );
      }
      print(result);
      if (result["data"] != null) {
        if (!isDoctor)
          _populateCurrentUser(
              result["data"]["user"], result["data"]["access_token"]);
        return true;
      }
      return false;
    } catch (e) {
      print("error=== $e");
      return false;
    }
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    _currentUser = null;
    _navigationService.navigateToNewRoute(LoginViewRoute);
  }
}
