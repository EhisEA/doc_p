import 'package:doc/app_router.dart';
import 'package:doc/manager/dialog_manager.dart';
import 'package:doc/services/dialog_service.dart';
import 'package:doc/services/navigationService.dart';
import 'package:doc/views/admin/admin_home.dart';
import 'package:doc/views/authentication/login_view.dart';
import 'package:doc/views/authentication/start_up_view.dart';
import 'package:doc/views/patient/create_report_view.dart';
import 'package:doc/views/patient/patient_home_view.dart';
import 'package:doc/views/report/report_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(); //*====registering get_it

  return runApp(
    //DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(),
    // )
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JALS',
      builder: (context, child) {
        var dialogService = locator<DialogService>();
        // return DevicePreview.appBuilder(
        //     context,
        //     Navigator(
        //       key: dialogService.dialogNavigationKey,
        //       onGenerateRoute: (settings) => MaterialPageRoute(
        //           builder: (context) => DialogManager(child: child)),
        //     ));

        /// wraping all widgets inside Navigator and diaglog
        return Navigator(
          key: dialogService.dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
            Future.wait([
              // preloading SVGs
              // loadSvg(context, "assets/svgs/d1.svg"),
            ]);
            return DialogManager(child: child);
          }),
        );
      },
      // theme: MyTheme().themeData,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: StartUpView(),
    );

    // home: VideoPlayer());
  }

  Future<SvgPicture> loadSvg(BuildContext context, String path) async {
    var picture = SvgPicture.asset(path);
    await precachePicture(picture.pictureProvider, context);
    return picture;
  }
}
