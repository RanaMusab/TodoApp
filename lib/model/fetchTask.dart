// To parse this JSON data, do
//
//     final allTask = allTaskFromJson(jsonString);

import 'dart:convert';

AllTask allTaskFromJson(String str) => AllTask.fromJson(json.decode(str));

String allTaskToJson(AllTask data) => json.encode(data.toJson());

class AllTask {
  AllTask({
    this.count,
    this.data,
  });

  int count;
  List<Datum> data;

  factory AllTask.fromJson(Map<String, dynamic> json) => AllTask(
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.completed,
    this.id,
    this.description,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool completed;
  String id;
  String description;
  String owner;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    completed: json["completed"],
    id: json["_id"],
    description: json["description"],
    owner: json["owner"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "completed": completed,
    "_id": id,
    "description": description,
    "owner": owner,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
