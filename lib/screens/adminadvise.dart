// My Project

import 'dart:developer';

import 'package:dagnosis_and_prediction/Widget/custom_buttons.dart';
import 'package:dagnosis_and_prediction/screens/admin_screen.dart';
import 'package:flutter/material.dart';

import 'package:parent_child_checkbox/parent_child_checkbox.dart';

final TextEditingController medicenController = TextEditingController();

class AdminAdvise extends StatefulWidget {
  const AdminAdvise({Key? key}) : super(key: key);

  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<AdminAdvise> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Diabetes Reading By Days'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Patient Name : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ahmed Saeed',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Gender : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Male',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Table(
                  //  defaultColumnWidth: FixedColumnWidth(90.0),
                  columnWidths: const {
                    0: FlexColumnWidth(5),
                    1: FlexColumnWidth(4),
                    2: FlexColumnWidth(5),
                    3: FlexColumnWidth(4),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                      color: Colors.black, style: BorderStyle.solid, width: 2),
                  children: [
                    TableRow(children: [
                      Column(children: const [
                        Text('rrrr',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                      Column(children: const [
                        Text('Glucose',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                      Column(children: const [
                        Text('Cholesterol',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                      Column(children: const [
                        Text('Actions',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: const [
                            Text('10/10/2010'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: const [
                            Text('260'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('150')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [
                          Text(
                            'Emergency Situation',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('12/10/2010')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('280')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('123')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [
                          Text('Emergency Situation',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                        ]),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('20/10/2010')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('140')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(children: const [Text('122')]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: const [
                            Text(
                              'Normal',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Doctor Advise : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ParentChildCheckbox(
                    parent: Text('Advise'),
                    children: const [
                      Text('Diet Food'),
                      Text('Medicine'),
                    ],
                    parentCheckboxColor: Color.fromARGB(255, 43, 0, 255),
                    childrenCheckboxColor: Colors.red,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: medicenController,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.edit),
                            labelText: 'Doctor Advise')),
                  ),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () {
                      log(ParentChildCheckbox.isParentSelected.toString());
                      log(ParentChildCheckbox.selectedChildrens.toString());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomButtons(
                  globalKey: _formkey,
                  buttontext: 'Go Back',
                  fontWeight: FontWeight.bold,
                  function: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()));
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
