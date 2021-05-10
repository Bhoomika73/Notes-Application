import 'package:meta/meta.dart';
import 'dart:convert';

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    this.id,
    this.title,
    this.note,
    this.v,
  });

  String id;
  String title;
  String note;
  int v;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["_id"],
        title: json["title"],
        note: json["note"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "note": note,
        "__v": v,
      };
}