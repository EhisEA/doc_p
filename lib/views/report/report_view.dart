import 'package:doc/model/report_model.dart';
import 'package:doc/views/report/view_models/report_view_model.dart';
import 'package:doc/widgets/loader_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key key, this.report}) : super(key: key);
  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportViewModel>.reactive(
      viewModelBuilder: () => ReportViewModel(report),
      builder: (context, model, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LoaderPage(
            busy: model.isBusy,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text("Report"),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView(
                        children: [
                          pMsgBox(
                              Replies(
                                author: model.report.author,
                                content: model.report.content,
                                date: model.report.date,
                                id: model.report.id,
                              ),
                              context),
                          ...List.generate(model.report.replies.length,
                              (index) {
                            if (model.report.replies[index].author.isDoctor) {
                              return dMsgBox(
                                  model.report.replies[index], context);
                            } else {
                              return pMsgBox(
                                  model.report.replies[index], context);
                            }
                          })
                          // pMsgBox("roland", context),
                          // dMsgBox("you'd be okay", context),
                          // pMsgBox(
                          //     "Using both ‘c’ and ‘s’ tags "
                          //     "you can create any path you would like "
                          //     "by simply chaining several together and "
                          //     "adjusting where all of the points are. I used "
                          //     "this technique to a great effect when creating the "
                          //     "waves for the header of emotivmusic.com. Using the knowledge "
                          //     "in this article and some python I ",
                          //     context),
                          // pMsgBox(
                          //     "Using both ‘c’ and ‘s’ tags "
                          //     "you can create any path you would like "
                          //     "by simply chaining several together and "
                          //     "adjusting where all of the points are. I used "
                          //     "this technique to a great effect when creating the "
                          //     "waves for the header of emotivmusic.com. Using the knowledge "
                          //     "in this article and some python I ",
                          //     context),
                          // dMsgBox(
                          //     "you can create any path you would like "
                          //     "by simply chaining several together and "
                          //     "adjusting where all of the points are. I used "
                          //     "this technique to a great effect when creating the ",
                          //     context),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      // height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 100,
                                minHeight: 20,
                              ),
                              // height: 50,
                              child: TextFormField(
                                controller: model.controller,
                                maxLines: null,
                                onChanged: (v) => model.checkTypingStatus(),
                                decoration: InputDecoration(
                                    hintText: "Type here..",
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: model.send,
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(left: 15),
                              duration: Duration(milliseconds: 500),
                              height: model.isTyping ? 50 : 0,
                              width: model.isTyping ? 50 : 0,
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pMsgBox(Replies reply, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 100,
            minHeight: 20,
          ),
          padding: EdgeInsets.all(10),
          // width:,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                reply.content,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Wednesday 02:23, July 04 2021",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dMsgBox(Replies reply, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Dr " + reply.author.name),
            SizedBox(height: 5),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 100,
                minHeight: 20,
              ),
              padding: EdgeInsets.all(10),
              // width:,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    reply.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    reply.date,
                    // "Wednesday 02:23, July 04 2021",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
