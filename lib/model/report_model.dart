import 'package:doc/model/user_model.dart';

class ReportModel {
  User author;
  String date;
  String title;
  String id;
  String content;
  List<Replies> replies;

  ReportModel(
      {this.author,
      this.content,
      this.date,
      this.id,
      this.replies,
      this.title});
  fromJson(Map json) {
    List<Replies> replies = [];
    json["replies"].forEach((item) {
      replies.add(Replies().fromJson(item));
    });
    return ReportModel(
      author: User().fromJson(json["author"], ""),
      date: json["created_at"],
      content: json["content"],
      id: json["public_id"],
      title: json["title"],
      replies: replies,
    );
  }
}

class Replies {
  User author;
  String id;
  String date;
  String content;

  Replies({this.author, this.content, this.date, this.id});

  fromJson(Map json) {
    return Replies(
        author: User().fromJson(json["author"], ""),
        date: json["created_at"],
        content: json["content"],
        id: json["public_id"]);
  }
}
