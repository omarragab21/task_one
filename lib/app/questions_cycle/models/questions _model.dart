import 'dart:convert';

class Questions {
  List<Item>? items;
  bool? hasMore;
  int quotaMax;
  int? quotaRemaining;

  Questions({
    this.items,
    this.hasMore,
    this.quotaMax = 0,
    this.quotaRemaining,
  });

  factory Questions.fromRawJson(String str) => Questions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        hasMore: json["has_more"],
        quotaMax: json["quota_max"],
        quotaRemaining: json["quota_remaining"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "has_more": hasMore,
        "quota_max": quotaMax,
        "quota_remaining": quotaRemaining,
      };
}

class Item {
  List<String>? tags;
  Owner? owner;
  bool? isAnswered;
  int? viewCount;
  int? answerCount;
  int? score;
  int? lastActivityDate;
  int? creationDate;
  int? questionId;
  ContentLicense? contentLicense;
  String? link;
  String? title;
  int? lastEditDate;
  int? acceptedAnswerId;
  int? protectedDate;

  Item({
    this.tags,
    this.owner,
    this.isAnswered,
    this.viewCount,
    this.answerCount,
    this.score,
    this.lastActivityDate,
    this.creationDate,
    this.questionId,
    this.contentLicense,
    this.link,
    this.title,
    this.lastEditDate,
    this.acceptedAnswerId,
    this.protectedDate,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        isAnswered: json["is_answered"],
        viewCount: json["view_count"],
        answerCount: json["answer_count"],
        score: json["score"],
        lastActivityDate: json["last_activity_date"],
        creationDate: json["creation_date"],
        questionId: json["question_id"],
        contentLicense: contentLicenseValues.map[json["content_license"]]!,
        link: json["link"],
        title: json["title"],
        lastEditDate: json["last_edit_date"],
        acceptedAnswerId: json["accepted_answer_id"],
        protectedDate: json["protected_date"],
      );

  Map<String, dynamic> toJson() => {
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "owner": owner?.toJson(),
        "is_answered": isAnswered,
        "view_count": viewCount,
        "answer_count": answerCount,
        "score": score,
        "last_activity_date": lastActivityDate,
        "creation_date": creationDate,
        "question_id": questionId,
        "content_license": contentLicenseValues.reverse[contentLicense],
        "link": link,
        "title": title,
        "last_edit_date": lastEditDate,
        "accepted_answer_id": acceptedAnswerId,
        "protected_date": protectedDate,
      };
}

enum ContentLicense { CC_BY_SA_30, CC_BY_SA_40 }

final contentLicenseValues = EnumValues(
    {"CC BY-SA 3.0": ContentLicense.CC_BY_SA_30, "CC BY-SA 4.0": ContentLicense.CC_BY_SA_40});

class Owner {
  int? accountId;
  int? reputation;
  int? userId;
  UserType? userType;
  int? acceptRate;
  String? profileImage;
  String? displayName;
  String? link;

  Owner({
    this.accountId,
    this.reputation,
    this.userId,
    this.userType,
    this.acceptRate,
    this.profileImage,
    this.displayName,
    this.link,
  });

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        accountId: json["account_id"],
        reputation: json["reputation"],
        userId: json["user_id"],
        userType: userTypeValues.map[json["user_type"]]!,
        acceptRate: json["accept_rate"],
        profileImage: json["profile_image"],
        displayName: json["display_name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "reputation": reputation,
        "user_id": userId,
        "user_type": userTypeValues.reverse[userType],
        "accept_rate": acceptRate,
        "profile_image": profileImage,
        "display_name": displayName,
        "link": link,
      };
}

enum UserType { DOES_NOT_EXIST, REGISTERED }

final userTypeValues =
    EnumValues({"does_not_exist": UserType.DOES_NOT_EXIST, "registered": UserType.REGISTERED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
