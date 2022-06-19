import 'dart:convert';

SleepRecord sleepRecordFromJson(String str) =>
    SleepRecord.fromJson(json.decode(str));

String sleepRecordToJson(SleepRecord data) => json.encode(data.toJson());

class SleepRecord {
  SleepRecord({
    this.id = 0,
    this.startDate = '',
    this.endDate = '',
    this.duration = '',
    this.dayOfTheWeek = '',
  });
  //constructor

  int id;
  String startDate;
  String endDate;
  String duration;
  String dayOfTheWeek;

  factory SleepRecord.fromJson(Map<String, dynamic> json) => SleepRecord(
        id: json["id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        duration: json["duration"],
        dayOfTheWeek: json["dayOfTheWeek"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "duration": duration,
        "dayOfTheWeek": dayOfTheWeek,
      };
}
