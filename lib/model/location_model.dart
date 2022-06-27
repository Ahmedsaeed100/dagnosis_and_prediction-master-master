// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Location {
  String? cityName;
  String? districtName;
  String? streetName;
  String? houseName;

  Location({
    this.cityName,
    this.districtName,
    this.streetName,
    this.houseName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cityName': cityName,
      'districtName': districtName,
      'streetName': streetName,
      'houseName': houseName,
    };
  }

  Location.fromMap(dynamic obj) {
    cityName = obj['cityName'];
    districtName = obj['districtName'];
    streetName = obj['streetName'];
    houseName = obj['houseName'];
  }

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}
