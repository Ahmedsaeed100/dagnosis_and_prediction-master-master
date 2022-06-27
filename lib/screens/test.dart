// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class yyyyyyyyy extends StatefulWidget {
  yyyyyyyyy({Key? key}) : super(key: key);

  @override
  _yyyyyyyyyState createState() => _yyyyyyyyyState();
}

class _yyyyyyyyyState extends State<yyyyyyyyy> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940, 1),
      lastDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            const SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}
