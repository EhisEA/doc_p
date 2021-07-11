import 'package:doc/views/authentication/login_view.dart';
import 'package:doc/views/authentication/view_models/sign_up_view_model.dart';
import 'package:doc/widgets/loader_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, _) {
          return LoaderPage(
            busy: model.isBusy,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.teal,
                  Colors.greenAccent,
                ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: model.form,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                right: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(60),
                                  bottomRight: Radius.circular(60),
                                ),
                              ),
                              // height: 300,
                              width: MediaQuery.of(context).size.width - 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: model.userController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Name",
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "name cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  TextFormField(
                                    controller: model.emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "email cannot be empty";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "email",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  TextFormField(
                                    controller: model.passwordController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "password cannot be empty";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: "Password",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: MediaQuery.of(context).size.width - 100,
                            child: GestureDetector(
                              onTap: model.signUp,
                              child: ClipOval(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      colors: [
                                        Colors.teal,
                                        Colors.greenAccent,
                                        // Colors.red,
                                      ],
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        child: Text("Already have an account? Login"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
