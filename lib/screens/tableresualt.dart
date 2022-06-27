// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dagnosis_and_prediction/model/collection.dart';
import 'package:dagnosis_and_prediction/screens/current_location.dart';
import 'package:dagnosis_and_prediction/screens/admin_screen.dart';

// ignore: must_be_immutable
class TableResualt extends StatefulWidget {
  Collection? collection;
  TableResualt({
    Key? key,
    this.collection,
  }) : super(key: key);

  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<TableResualt> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Diabetes Reading By Days'),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Patient Name : ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.collection!.firstName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gender : ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.collection!.gender.toString(),
                            style: const TextStyle(
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
            const SizedBox(
              height: 20,
            ),
            // Start Insert List View Horisontal List
            SizedBox(
              height: 290,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    TableContent(widget.collection),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                itemCount: 1,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCurrentLocation(
                      email: widget.collection!.email.toString(),
                    ),
                  ),
                );
              },
              icon: const Icon(
                  Icons.add_location_rounded), //icon data for elevated button
              label: const Text("Find Patient Location"), //label text
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(
                    255, 68, 255, 93), //elevated btton background color
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminScreen(
                            collection: widget.collection,
                          )),
                );
              },
              icon: const Icon(
                  Icons.assignment_return), //icon data for elevated button
              label: const Text("Go Back"), //label text
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(
                255,
                255,
                68,
                68,
              ) //elevated btton background color
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget TableContent(
        Collection? collection) => // start messenger horisental list

    Center(
        child: Column(children: [
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(110.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: const [
                    Text('Days',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ]),
                  Column(children: const [
                    Text('Glucose Rate',
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
                    Text('Diet Food',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ]),
                  Column(children: const [
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
                    child: Column(children: [
                      Text(
                        collection!.date.toString(),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [
                      Text(
                        collection.glucoserate.toString(),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [
                      Text(
                        collection.cholesterol.toString(),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [
                      Text(
                        collection.doctoradvise.toString(),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(children: [
                      Text(
                        collection.medicine.toString(),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: const [
                      Text(
                        'Emergency Situation',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      )
                    ]),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    ]));
