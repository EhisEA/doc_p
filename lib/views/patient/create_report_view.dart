import 'package:doc/views/patient/view_models/create_report_view_model.dart';
import 'package:doc/widgets/loader_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateReportView extends StatelessWidget {
  const CreateReportView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateReportViewModel>.reactive(
        viewModelBuilder: () => CreateReportViewModel(),
        builder: (context, model, _) {
          return LoaderPage(
            busy: model.isBusy,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: Text("Create Report"),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: model.titleController,
                          decoration: InputDecoration(
                            hintText: "Title",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Stack(
                        fit: StackFit.loose,
                        children: [
                          Container(
                            height: 320,
                          ),
                          GestureDetector(
                            onTap: () {
                              model.reportFoucs.requestFocus();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20.0),
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                controller: model.reportController,
                                focusNode: model.reportFoucs,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type your report here...",
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 290,
                            right: 10,
                            child: GestureDetector(
                              onTap: model.sendReport,
                              child: AnimatedContainer(
                                margin: EdgeInsets.only(left: 15),
                                duration: Duration(milliseconds: 500),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    colors: [
                                      Colors.teal,
                                      Colors.greenAccent,
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
