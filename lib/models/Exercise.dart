import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));

String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  Exercise({
    this.id = 0,
    this.duration = '',
    this.exerciseDate = '',
    this.dayOfTheWeek = '',
  });
  //constructor

  int id;
  String duration;
  String exerciseDate;
  String dayOfTheWeek;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        duration: json["duration"],
        exerciseDate: json["exerciseDate"],
        dayOfTheWeek: json["dayOfTheWeek"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "exerciseDate": exerciseDate,
        "dayOfTheWeek": dayOfTheWeek,
      };
}
