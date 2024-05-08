import 'dart:convert';

ModelGaleri modelGaleriFromJson(String str) => ModelGaleri.fromJson(json.decode(str));

String modelGaleriToJson(ModelGaleri data) => json.encode(data.toJson());

class ModelGaleri {
  String message;
  List<Result> result;

  ModelGaleri({
    required this.message,
    required this.result,
  });

  factory ModelGaleri.fromJson(Map<String, dynamic> json) => ModelGaleri(
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
  String image;

  Result({
    required this.title,
    required this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}