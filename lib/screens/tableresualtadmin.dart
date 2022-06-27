import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/User_Health_model.dart';
import 'package:dagnosis_and_prediction/screens/current_location.dart';
import 'package:dagnosis_and_prediction/screens/userchart.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

// Imports all Widgets included in [multiselect] package
// import 'package:horizontal_data_table/horizontal_data_table.dart';

final TextEditingController medicenController = TextEditingController();

// ignore: must_be_immutable
class TableResualtadmin extends StatefulWidget {
  String? userEmail;
  String? gender;
  String? name;
  TableResualtadmin({
    Key? key,
    this.userEmail,
    this.name,
    this.gender,
  }) : super(key: key);

  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<TableResualtadmin> {
  List<String> selected = [];
  List<UserHealth> users = [];
  @override
  void initState() {
    super.initState();
    getusers();
  }

  getusers() async {
    // print('rrrrr${widget.userEmail}');
    users = await DBHelper.userHeathList('${widget.userEmail}');
    print('rrrrrrr${users.length}');
    return users;
  }

  doctorAdvice(List<String> selected, String doctoradvise) async {
    if (selected.isEmpty) {
      return;
    }
    var food = '';
    var medicineadvice = '';
    selected.map((e) {
      if (e == 'Diet Food') {
        food = e;
      } else if (e == 'Medicine') {
        medicineadvice = e;
      }
    }).toList();

    if (food != '' && medicineadvice != '') {
      await DBHelper.updateDoctorAdvice(
        email: widget.userEmail.toString(),
        doctoradvise: '$food  , $medicineadvice : $doctoradvise',
      );
    } else if (food != '') {
      await DBHelper.updateDoctorAdvice(
        email: widget.userEmail.toString(),
        doctoradvise: '$food :  $doctoradvise',
      );
    } else if (medicineadvice != '') {
      await DBHelper.updateDoctorAdvice(
        email: widget.userEmail.toString(),
        doctoradvise: '$medicineadvice :  $doctoradvise',
      );
    }

    getusers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Diabetes Reading By Days'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              children: [
                Center(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
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
                                widget.name.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
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
                          const Text(
                            'Gender : ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.gender.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
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
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => FutureBuilder(
                    future: getusers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return users.isEmpty
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text("No user Data"),
                              ))
                            : TableContent(users, context);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
                separatorBuilder: (context, index) => const SizedBox(width: 20),
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
                      email: widget.userEmail.toString(),
                    ),
                  ),
                );
              },
              icon: const Icon(
                  Icons.add_location_rounded), //icon data for elevated button
              label: const Text("Find Patient Location"), //label text
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(
                      255, 68, 255, 93) //elevated btton background color
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(children: const [
                  Text(
                    'Doctor Advise : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                ])),

            const SizedBox(height: 5),

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
                      //  print('5555555 ${x.toString()}');
                    });
                  },
                  options: const ['Diet Food', 'Medicine'],
                  selectedValues: selected,
                  whenEmpty: ('Select Something'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: 200,
              child: TextFormField(
                decoration: const InputDecoration(
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
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(
                  () {
                    if (selected.isEmpty) {
                      //your code goes here
                      var snackBars = const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("rrrrrrrr"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBars);
                      return;
                    } else {
                      doctorAdvice(selected, medicenController.text);
                    }
                  },
                );
                // log(ParentChildCheckbox.isParentSelected.toString());
                // log(ParentChildCheckbox.selectedChildrens.toString());
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserChart(
                      userEmail: widget.userEmail.toString(),
                    ),
                  ),
                );
              },
              icon: const Icon(
                  Icons.assignment_return), //icon data for elevated button
              label: const Text("Health Report"), //label text
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(
                  255,
                  68,
                  255,
                  146,
                ), //elevated btton background color
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}

List<TableRow> getList(List<UserHealth> users, BuildContext context) {
  var ishavediabetes = 0;
  var lastDrAdvaice = 0;
  List<TableRow> childs = [];

  for (var i in users) {
    lastDrAdvaice += 1;
    if (i.glucoserate! >= 200) {
      ishavediabetes += 1;
      if (ishavediabetes > 1) {
        Future.delayed(Duration.zero, () {
          //your code goes here
          var snackBar = const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Unfortunately, you have diabetes"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    }
    childs.add(
      TableRow(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                i.date.toString(),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                i.glucoserate.toString(),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                i.cholesterol.toString(),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                users.length == lastDrAdvaice ? i.doctoradvise.toString() : '',
              ),
            ),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                  onPressed: () {
                    DBHelper.deleteRowInHealth(
                      i.id!.toInt(),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => TableResualtadmin(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                i.glucoserate! >= 200 ? 'Emergency Situation' : 'normal',
                style: TextStyle(
                  color: i.glucoserate! >= 200 ? Colors.red : Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  return childs;
}

// ignore: non_constant_identifier_names
Widget TableContent(List<UserHealth> users,
        BuildContext context) => // start messenger horisental list

    Center(
        child: Column(children: <Widget>[
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(110.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(
                  children: [
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
                      Text('Doctor Advise',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ]),
                    Column(
                      children: const [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Text(
                          'Action',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ...getList(users, context),
              ],
            ),
          ),
        ),
      ),
    ]));
