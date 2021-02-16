// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
  String cevaplar;
  int id;
  String name;
  int userId;

  Test({
    this.cevaplar,
    this.id,
    this.name,
    this.userId,
  });

  Test copyWith({
    String cevaplar,
    int id,
    String name,
    int userId,
  }) =>
      Test(
        cevaplar: cevaplar ?? this.cevaplar,
        id: id ?? this.id,
        name: name ?? this.name,
        userId: userId ?? this.userId,
      );

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    cevaplar: json["cevaplar"],
    id: json["id"],
    name: json["name"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "cevaplar": cevaplar,
    "id": id,
    "name": name,
    "user_id": userId,
  };
}
