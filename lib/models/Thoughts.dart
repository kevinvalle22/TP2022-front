import 'dart:convert';

Thought welcomeFromJson(String str) => Thought.fromJson(json.decode(str));

String welcomeToJson(Thought data) => json.encode(data.toJson());

class Thought {
  Thought({
    this.id = 0,
    this.message = '',
    this.createdAt=''
  });
  int id;
  String message;
  String createdAt;
  factory Thought.fromJson(Map<String, dynamic> json) => Thought(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "createdAt": createdAt,
      };
}
