import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));

String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  Exercise({
    this.id = 0,
    this.duration = '',
    this.exerciseDate = '',
  });
  //constructor

  int id;
  String duration;
  String exerciseDate;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        duration: json["duration"],
        exerciseDate: json["exerciseDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "exerciseDate": exerciseDate,
      };
}
