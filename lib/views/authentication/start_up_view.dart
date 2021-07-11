import 'package:doc/views/authentication/view_models/start_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (model) => model.checkLogin(),
        builder: (context, model, _) {
          return Scaffold();
        });
  }
}
