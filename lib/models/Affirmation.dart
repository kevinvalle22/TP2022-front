import 'dart:convert';

Affirmation welcomeFromJson(String str) =>
    Affirmation.fromJson(json.decode(str));

String welcomeToJson(Affirmation data) => json.encode(data.toJson());

class Affirmation {
  Affirmation({
    this.message = '',
    this.affirmationDate = '',
    this.mondayActive = false,
    this.tuesdayActive = false,
    this.wednesdayActive = false,
    this.thursdayActive = false,
    this.fridayActive = false,
    this.saturdayActive = false,
    this.sundayActive = false,
  });

  String message;
  String affirmationDate;
  bool mondayActive;
  bool tuesdayActive;
  bool wednesdayActive;
  bool thursdayActive;
  bool fridayActive;
  bool saturdayActive;
  bool sundayActive;

  factory Affirmation.fromJson(Map<String, dynamic> json) => Affirmation(
        message: json["message"],
        affirmationDate: json["affirmationDate"],
        mondayActive: json["mondayActive"],
        tuesdayActive: json["tuesdayActive"],
        wednesdayActive: json["wednesdayActive"],
        thursdayActive: json["thursdayActive"],
        fridayActive: json["fridayActive"],
        saturdayActive: json["saturdayActive"],
        sundayActive: json["sundayActive"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "affirmationDate": affirmationDate,
        "mondayActive": mondayActive,
        "tuesdayActive": tuesdayActive,
        "wednesdayActive": wednesdayActive,
        "thursdayActive": thursdayActive,
        "fridayActive": fridayActive,
        "saturdayActive": saturdayActive,
        "sundayActive": sundayActive,
      };
}
