// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserHealth {
  int? id;
  String? email;
  int? highbloodpressure;
  int? lowerbloodpressure;
  int? weight;
  int? height;
  int? cholesterol;
  String? medicine;
  String? diabetesinfamily; // yes / no
  String? date;
  int? glucoserate;
  double? skinfoldthickness; // null ok
  String? doctoradvise; // null ok
  // null ok

  UserHealth({
    this.id,
    this.email,
    this.highbloodpressure,
    this.lowerbloodpressure,
    this.weight,
    this.height,
    this.cholesterol,
    this.medicine,
    this.diabetesinfamily,
    this.date,
    this.glucoserate,
    this.skinfoldthickness,
    this.doctoradvise,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'highbloodpressure': highbloodpressure,
      'lowerbloodpressure': lowerbloodpressure,
      'weight': weight,
      'height': height,
      'cholesterol': cholesterol,
      'medicine': medicine,
      'diabetesinfamily': diabetesinfamily,
      'date': date,
      'glucoserate': glucoserate,
      'skinfoldthickness': skinfoldthickness,
      'doctoradvise': doctoradvise,
    };
  }

  UserHealth.fromMap(dynamic obj) {
    id = obj['id'];
    email = obj['email'];
    highbloodpressure = obj['highbloodpressure'];
    lowerbloodpressure = obj['lowerbloodpressure'];

    weight = obj['weight'];
    height = obj['height'];
    cholesterol = obj['cholesterol'];
    medicine = obj['medicine'];
    diabetesinfamily = obj['diabetesinfamily'];
    date = obj['date'];
    glucoserate = obj['glucoserate'];
    skinfoldthickness = obj['skinfoldthickness'];
    doctoradvise = obj['doctoradvise'];
  }

  factory UserHealth.fromJson(String source) =>
      UserHealth.fromMap(json.decode(source) as Map<String, dynamic>);
}
