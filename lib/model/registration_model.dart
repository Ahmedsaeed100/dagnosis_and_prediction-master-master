// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Registration {
  String? firstName;
  String? secondName;
  String? nikeName;
  String? email;
  String? password;
  String? gender;
  String? birthdate;
  String? latitude;
  String? longitude;

  Registration({
    this.firstName,
    this.secondName,
    this.nikeName,
    this.email,
    this.password,
    this.gender,
    this.birthdate,
    this.latitude,
    this.longitude,
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
    };
  }

  Registration.fromMap(dynamic obj) {
    firstName = obj['firstName'];
    secondName = obj['secondName'];
    nikeName = obj['nikeName'];
    email = obj['email'];
    password = obj['password'];
    gender = obj['gender'];
    birthdate = obj['birthdate'];
    latitude = obj['latitude'];
    longitude = obj['longitude'];
  }

  factory Registration.fromJson(String source) =>
      Registration.fromMap(json.decode(source) as Map<String, dynamic>);
}
