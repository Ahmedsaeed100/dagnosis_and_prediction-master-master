import 'package:dagnosis_and_prediction/screens/current_location.dart';
import 'package:dagnosis_and_prediction/screens/userchart.dart';
import 'package:dagnosis_and_prediction/screens/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

import 'package:parent_child_checkbox/parent_child_checkbox.dart';

// Imports all Widgets included in [multiselect] package

// import 'package:horizontal_data_table/horizontal_data_table.dart';

void main() {
  runApp(TableResualtadmina());
}

final TextEditingController medicenController = TextEditingController();

class TableResualtadmina extends StatefulWidget {
  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<TableResualtadmina> {
  @override
  final _formkey = GlobalKey<FormState>();
  List<String> selected = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Diabetes Reading By Days'),
              // backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.red),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminScreen()));
                },
              ),
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Container(
                child: Column(
                  children: [
                    Center(
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Patient Name : ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'ahmed saeed',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  'Gender : ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Start Insert List View Horisontal List
              Container(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TableContent(),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ),
                  itemCount: 1,
                ),
              ),

              const SizedBox(
                height: 30,
                width: 300,
              ),

              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyCurrentLocation(
                                email: '',
                              )),
                    );
                  },
                  icon: Icon(Icons
                      .add_location_rounded), //icon data for elevated button
                  label: Text("Find Patient Location"), //label text
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 68, 255, 93) //elevated btton background color
                      )),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(children: [
                    Text(
                      'Doctor Advise : ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  ])),

              Padding(
                padding: const EdgeInsets.all(2.0),
               // DropDownMultiSelect comes from multiselect
                child: SizedBox(
                  width: 200,
                  // margin: EdgeInsets.symmetric(horizontal: 70),
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        selected = x;
                      });
                    },
                    options: ['Diet Food', 'Medicine'],
                    selectedValues: selected,
                    whenEmpty: ('Select Something'),
                  ),
                ),
              ),

              SizedBox(height: 5),

              SizedBox(
                width: 200,
                child: TextFormField(
                  decoration: InputDecoration(
                    // hintText: 'Note',
                    labelText: "Doctor Note",

                    border: OutlineInputBorder(),

                    prefixIcon: Icon(Icons.edit),
                  ),
                  controller: medicenController,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    medicenController.text = value!;
                  },
                ),
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  // log(ParentChildCheckbox.isParentSelected.toString());
                  // log(ParentChildCheckbox.selectedChildrens.toString());
                },
              ),
              SizedBox(
                height: 20,
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserChart()),
                  );
                },
                icon: Icon(
                    Icons.assignment_return), //icon data for elevated button
                label: Text("Health Report"), //label text
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                  255,
                  68,
                  255,
                  146,
                ) //elevated btton background color
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              // ElevatedButton.icon(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => AdminScreen()),
              //       );
              //     },
              //     icon: Icon(
              //         Icons.assignment_return), //icon data for elevated button
              //     label: Text("Go Back"), //label text
              //     style: ElevatedButton.styleFrom(
              //         primary: Color.fromARGB(
              //             255, 255, 68, 68) //elevated btton background color
              //         )),
            ]))));
  }
}

Widget TableContent() => // start messenger horisental list

    Center(
        child: Column(children: <Widget>[
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Table(
              defaultColumnWidth: FixedColumnWidth(110.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: [
                    Text('Days',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                  Column(children: [
                    Text('Glucose Rate',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                  Column(children: [
                    Text('Cholesterol',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                  Column(children: [
                    Text('Diet Food',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ]),
                  Column(children: [
                    Text('Medicine',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                  Column(children: [
                    Text('Action',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('10/10/2021')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('200')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('125')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Diet Food')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Medicen')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('10/10/2021')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('200')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('125')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Diet Food')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Medicen')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('10/10/2021')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('100')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('125')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Diet Food')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Medicen')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      Text('Normal',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent))
                    ]),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('10/10/2021')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('133')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('122')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Diet Food 1')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [Text('Medicen 1')]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      Text('Normal',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent))
                    ]),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    ]));
