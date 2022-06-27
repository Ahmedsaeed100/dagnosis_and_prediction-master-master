import 'dart:ffi';

import 'package:dagnosis_and_prediction/model/User_Health_model.dart';
import 'package:dagnosis_and_prediction/model/collection.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _registration = 'registration';
  static const String _userHealth = 'userHealth';
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'localDB.db';
        debugPrint('in Data base');
        debugPrint(_path);
        _db = await openDatabase(_path, version: _version,
            onCreate: (_db, int version) async {
          debugPrint('in Data base');
          // When creating the db, create the table
          await _db.execute('''
            CREATE TABLE $_registration (
            id INTEGER PRIMARY KEY autoincrement,
            firstName TEXT,
            secondName TEXT,
            nikeName TEXT,
            email TEXT,
            password TEXT,
            gender TEXT,
            birthdate TEXT,
            latitude TEXT,
            longitude TEXT
            )''');
          //email, highbloodpressure, lowerbloodpressure, date, weight, height, cholesterol, medicine, diabetesinfamily
          await _db.execute('''
            CREATE TABLE $_userHealth (
            id INTEGER PRIMARY KEY autoincrement,
            email TEXT,
            highbloodpressure INTEGER,
            lowerbloodpressure INTEGER,
            weight INTEGER,
            height INTEGER,
            cholesterol INTEGER,
            medicine TEXT,
            diabetesinfamily TEXT,
            date TEXT,
            glucoserate INTEGER,
            skinfoldthickness REAL,
            doctoradvise TEXT
            )''');
        });
        debugPrint('Database Creeated');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

// Insert Into Database User Registration
  static Future<int> userRegistration(Registration registration) async {
    debugPrint("insert");
    String? email = registration.email;
    // Check Email is Exist
    var emailExist = await _db
        ?.rawQuery("SELECT * FROM $_registration WHERE email = '$email'");

    // ignore: prefer_is_empty
    if (emailExist!.length == 0) {
      try {
        return await _db!.insert(_registration, registration.toJson());
      } catch (e) {
        return 0;
      }
    } else {
      return 0;
    }
  }

// Insert Into Database User Health
  static Future<int> insertUserHealth(UserHealth userHealth) async {
    //debugPrint("insert");
    // print("hhhhhhhhhhhhh${_db?.rawQuery(_userHealth)}");
    try {
      return await _db!.insert(_userHealth, userHealth.toJson());
    } catch (e) {
      print('kkkkkkkkkkk$e');
      return 0;
    }
  }

// Insert By Line By query
  static insert2() async {
    debugPrint("insert2");
    await _db!.rawInsert(
        "INSERT INTO $_registration (firstName) VALUES ('AHMED SSSSSSS') ");
    List<Map<String, Object?>>? response =
        await _db?.rawQuery('SELECT * FROM $_registration');
    print(response);
  }

// Delete By Email Address Registration
  static Future<int> deleteRowRegistration(Registration? registration) async {
    debugPrint("delete");
    return await _db!.delete(
      _registration,
      where: 'email = ?',
      whereArgs: [registration!.email],
    );
  }

// Delete By Email Address Ueser Health
  static Future<int> deleteRowInHealth(int id) async {
    debugPrint("delete");
    return await _db!.delete(
      _userHealth,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Delete All Rows In Database
  static Future<int> deleteAllDBRows() async {
    debugPrint("delete All Rows DB ROWS");
    return await _db!.delete(_registration);
  }

// Ubdate Database By Email
  static Future<int> update(String? email) async {
    debugPrint("update");
    return await _db!.rawUpdate('''
      UPDATE $_registration
      SET isCompleted = ?
      WHERE id = ?
''', [1, email]);
  }

// Query by Table Name -- Read Data
  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint("Query");
    print(_db!.query(_registration));
    List<Map<String, Object?>>? response =
        await _db?.rawQuery('SELECT * FROM $_registration');
    print(response);
    return await _db!.query(_registration);
  }

  static Future<List<Map<String, dynamic>>> healthQuery() async {
    debugPrint("Query");
    print(_db!.query(_registration));
    List<Map<String, Object?>>? response =
        await _db?.rawQuery('SELECT * FROM $_registration');
    print(response);
    return await _db!.query(_registration);
  }

  static Future<List<Map<String, Object?>>?> queries() async {
    try {
      var res = await _db?.rawQuery('SELECT * FROM $_registration');

      if (res?.isNotEmpty == true) {
        Future<List<Registration>> userdata =
            Registration.fromMap(res) as Future<List<Registration>>;
        // query();
        debugPrint('ssssssssssss $userdata');
        return res;
      }
      print("Not Exist");
      return null;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<List<Registration>> getuserlist() async {
    // Query the table for all The getuserlist.
    final List<Map<String, dynamic>> maps = await _db!.query(_registration);

    // Convert the List<Map<String, dynamic> into a List<Recipe>.
    return List.generate(maps.length, (i) {
      return Registration(
        email: maps[i]['email'],
        firstName: maps[i]['firstName'],
        gender: maps[i]['gender'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        // Same for the other properties
      );
    }).where((element) => element.email != 'adeeb@gmail.com').toList();
  }

  static Future<List<Collection>> getcolliction() async {
    // rawQuery with Left Join over 2 Tables

    List<Map<String, dynamic>> maps = await _db!
        .rawQuery('''SELECT $_registration.email, $_registration.firstName,
        $_registration.secondName, $_registration.nikeName, $_registration.gender,
        $_registration.birthdate, $_registration.latitude, $_registration.longitude,
       $_userHealth.highbloodpressure, $_userHealth.lowerbloodpressure, $_userHealth.height, 
       $_userHealth.weight, $_userHealth.cholesterol, $_userHealth.medicine, $_userHealth.diabetesinfamily,
       $_userHealth.date, $_userHealth.glucoserate, $_userHealth.skinfoldthickness,
       $_userHealth.doctoradvise
        FROM $_registration INNER JOIN $_userHealth
         ON  $_registration.email = $_userHealth.email''');

    return List.generate(maps.length, (i) {
      return Collection(
        email: maps[i]['email'],
        firstName: maps[i]['firstName'],
        secondName: maps[i]['secondName'],
        nikeName: maps[i]['nikeName'],
        gender: maps[i]['gender'],
        birthdate: maps[i]['birthdate'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        highbloodpressure: maps[i]['highbloodpressure'],
        lowerbloodpressure: maps[i]['lowerbloodpressure'],
        height: maps[i]['height'],
        weight: maps[i]['weight'],
        cholesterol: maps[i]['cholesterol'],
        medicine: maps[i]['medicine'],
        diabetesinfamily: maps[i]['diabetesinfamily'],
        date: maps[i]['date'],
        glucoserate: maps[i]['glucoserate'],
        skinfoldthickness: maps[i]['skinfoldthickness'],
        doctoradvise: maps[i]['doctoradvise'],
        // Same for the other properties
      );
    });
  }

  static Future<List<Collection>> geteUserData() async {
    // rawQuery with Left Join over 2 Tables

    List<Map<String, dynamic>> maps = await _db!
        .rawQuery('''SELECT $_registration.email, $_registration.firstName,
      $_userHealth.glucoserate
        FROM $_registration INNER JOIN $_userHealth
         ON  $_registration.email = $_userHealth.email''');

    return List.generate(maps.length, (i) {
      return Collection(
        email: maps[i]['email'],
        firstName: maps[i]['firstName'],
        glucoserate: maps[i]['glucoserate'],
        // Same for the other properties
      );
    });
  }

  // User Login
  static Future<Registration?> getLogin(String email, String password) async {
    try {
      var res = await _db?.rawQuery(
          "SELECT * FROM $_registration WHERE email = '$email' and password = '$password'");

      if (res!.isNotEmpty == true) {
        Registration userdata = Registration.fromMap(res.first);
        // query();
        debugPrint('ssssssssssss $userdata');
        return userdata;
      }
      print("Not Exist");
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
  // check if user has add heath state

  static Future<UserHealth?> checkUserHasHeathState(String email) async {
    try {
      var res = await _db
          ?.rawQuery("SELECT * FROM $_userHealth WHERE email = '$email'");
      if (res!.isNotEmpty == true) {
        UserHealth userdata = UserHealth.fromMap(res.first);
        // query();
        debugPrint('ssssssssssss $userdata');
        return userdata;
      }
      print("Not Exist");
      return null;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<List<UserHealth>> userHeathList(String email) async {
    // rawQuery with Left Join over 2 Tables

    List<Map<String, dynamic>> maps = await _db!
        .rawQuery('''SELECT  * FROM  $_userHealth WHERE email = '$email' ''');

    return List.generate(maps.length, (i) {
      return UserHealth(
        id: maps[i]['id'],
        email: maps[i]['email'],
        highbloodpressure: maps[i]['highbloodpressure'],
        lowerbloodpressure: maps[i]['lowerbloodpressure'],
        height: maps[i]['height'],
        weight: maps[i]['weight'],
        cholesterol: maps[i]['cholesterol'],
        medicine: maps[i]['medicine'],
        diabetesinfamily: maps[i]['diabetesinfamily'],
        date: maps[i]['date'],
        glucoserate: maps[i]['glucoserate'],
        skinfoldthickness: maps[i]['skinfoldthickness'],
        doctoradvise: maps[i]['doctoradvise'],
        // Same for the other properties
      );
    });
  }

// User Login
  // ignore: body_might_complete_normally_nullable
  static Future<Registration?> getuserLocation(String email) async {
    try {
      var res = await _db
          ?.rawQuery("SELECT * FROM $_registration WHERE email = '$email'");

      if (res?.isNotEmpty == true) {
        Registration userdata = Registration.fromMap(res!.first);
        // query();
        debugPrint('ssssssssssss ${userdata.firstName}');
        return userdata;
      }
      print("Not Exist");
    } catch (e) {
      print(e.toString());
    }
  }

  // Update Health diat food
  static Future updateDoctorAdvice(
      {String email = 'a@a.com', String doctoradvise = ''}) async {
    // Update some record
    await _db!.rawQuery('''
      UPDATE $_userHealth SET 'doctoradvise' = '$doctoradvise'
      WHERE email='$email';
      ''');
  }

// Query by Table Name -- Read Data
  static Future<List<Map<String, dynamic>>> query2() async {
    debugPrint("Query");
    print(_db!.query(_registration));
    return await _db!.query(_registration);
  }

// Close Database
  static closeDb() async {
    await _db!.close();
  }
}
