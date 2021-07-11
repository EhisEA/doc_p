import 'dart:math';

import 'package:doc/model/report_model.dart';
import 'package:doc/views/admin/view_models/admin_home_view_model.dart';
import 'package:doc/views/report/report_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class AdminHomeView extends StatelessWidget {
  AdminHomeView({Key key}) : super(key: key);

  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminHomeViewModel>.reactive(
      viewModelBuilder: () => locator<AdminHomeViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) => model.getReport(),
      builder: (context, model, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Welcome ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        model.name,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: model.logOut,
                          child: Icon(Icons.power_settings_new_outlined))
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Reports",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: model.createDoctor,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Create doctor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 15),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: model.isBusy
                        ? Center(child: CircularProgressIndicator())
                        : model.reports == null
                            ? GestureDetector(
                                onTap: model.getReport,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.replay_outlined),
                                      Text("retry"),
                                    ],
                                  ),
                                ),
                              )
                            : model.reports.isEmpty
                                ? Center(
                                    child: Text(
                                      "No report yet",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: model.reports.length,
                                    itemBuilder: (context, index) {
                                      return reportCard(
                                          model.reports[index], context);
                                    },
                                  ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget reportCard(ReportModel report, BuildContext context) {
    List<String> r = report.date.split(",");
    List<String> w = r[1].trim().split(" ");
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReportView(report: report)));
      },
      child: Container(
        padding: EdgeInsets.all(0),
        child: Row(
          children: [
            Container(
              color: Color.fromRGBO(random.nextInt(225), random.nextInt(225),
                  random.nextInt(225), 1),
              width: 10,
              height: 90,
            ),
            SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  w[0],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  w[1],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                report.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            Text(
              report.replies.length.toString(),
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
