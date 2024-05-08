import 'dart:convert';

ListBudaya listBudayaFromJson(String str) => ListBudaya.fromJson(json.decode(str));

String listBudayaToJson(ListBudaya data) => json.encode(data.toJson());

class ListBudaya {
  String message;
  List<Result> result;

  ListBudaya({
    required this.message,
    required this.result,
  });

  factory ListBudaya.fromJson(Map<String, dynamic> json) => ListBudaya(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  String title;
  String content;
  String image;

  Result({
    required this.title,
    required this.content,
    required this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    content: json["content"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "image": image,
  };
}