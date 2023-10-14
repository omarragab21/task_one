import 'dart:convert';

class QuestionItemModel {
  int? id;
  String? displayname;
  String? profileimage;
  int? answerd;
  int? creditdate;
  String? title;
  int? countanswerd;
  String? linkquestion;
  String? questionid;

  QuestionItemModel({
    this.id,
    this.displayname,
    this.profileimage,
    this.answerd,
    this.creditdate,
    this.title,
    this.countanswerd,
    this.linkquestion,
    this.questionid,
  });

  factory QuestionItemModel.fromRawJson(String str) => QuestionItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionItemModel.fromJson(Map<String, dynamic> json) => QuestionItemModel(
        id: json["id"],
        displayname: json["displayname"],
        profileimage: json["profileimage"],
        answerd: json["answerd"],
        creditdate: json["creditdate"],
        title: json["title"],
        countanswerd: json["countanswerd"],
        linkquestion: json["linkquestion"],
        questionid: json["questionid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayname": displayname,
        "profileimage": profileimage,
        "answerd": answerd,
        "creditdate": creditdate,
        "title": title,
        "countanswerd": countanswerd,
        "linkquestion": linkquestion,
        "questionid": questionid,
      };
}
