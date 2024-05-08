import 'dart:convert';

ModelSejarawan modelSejarawanFromJson(String str) => ModelSejarawan.fromJson(json.decode(str));

String modelSejarawanToJson(ModelSejarawan data) => json.encode(data.toJson());

class ModelSejarawan {
  String message;
  List<Result> result;

  ModelSejarawan({
    required this.message,
    required this.result,
  });

  factory ModelSejarawan.fromJson(Map<String, dynamic> json) => ModelSejarawan(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String name;
  String birthdate;
  String origin;
  String sex;
  String description;
  String image;

  Result({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.origin,
    required this.sex,
    required this.description,
    required this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    birthdate: json["birthdate"],
    origin: json["origin"],
    sex: json["sex"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "birthdate": birthdate,
    "origin": origin,
    "sex": sex,
    "description": description,
    "image": image,
  };
}
