import 'dart:convert';

class Collection {
  String? firstName;
  String? secondName;
  String? nikeName;
  String? email;
  String? password;
  String? gender;
  String? birthdate;
  String? latitude;
  String? longitude;

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

  Collection({
    this.firstName,
    this.secondName,
    this.nikeName,
    this.email,
    this.password,
    this.gender,
    this.birthdate,
    this.latitude,
    this.longitude,
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
      'firstName': firstName,
      'secondName': secondName,
      'nikeName': nikeName,
      'email': email,
      'password': password,
      'gender': gender,
      'birthdate': birthdate,
      'latitude': latitude,
      'longitude': longitude,
      //
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

  Collection.fromMap(dynamic obj) {
    firstName = obj['firstName'];
    secondName = obj['secondName'];
    nikeName = obj['nikeName'];
    email = obj['email'];
    password = obj['password'];
    gender = obj['gender'];
    birthdate = obj['birthdate'];
    latitude = obj['latitude'];
    longitude = obj['longitude'];
    longitude = obj['longitude'];
    highbloodpressure = obj['highbloodpressure'];
    lowerbloodpressure = obj['lowerbloodpressure'];
    weight = obj['weight'];
    height = obj['height'];
    medicine = obj['medicine'];
    diabetesinfamily = obj['diabetesinfamily'];
    date = obj['date'];
    glucoserate = obj['glucoserate'];
    skinfoldthickness = obj['skinfoldthickness'];
    doctoradvise = obj['doctoradvise'];
  }

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);
}
