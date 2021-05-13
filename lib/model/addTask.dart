// To parse this JSON data, do
//
//     final addTask = addTaskFromJson(jsonString);

import 'dart:convert';

AddTask addTaskFromJson(String str) => AddTask.fromJson(json.decode(str));

String addTaskToJson(AddTask data) => json.encode(data.toJson());

class AddTask {
  AddTask({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory AddTask.fromJson(Map<String, dynamic> json) => AddTask(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
