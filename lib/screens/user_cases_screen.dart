import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/User_Health_model.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:dagnosis_and_prediction/screens/add_User_Health.dart';
import 'package:flutter/material.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';

// ignore: must_be_immutable
class UserCasseScreen extends StatefulWidget {
  Registration? userInfo;

  UserCasseScreen({
    Key? key,
    this.userInfo,
  }) : super(key: key);

  @override
  _TableExample createState() => _TableExample();
}

class _TableExample extends State<UserCasseScreen> {
  List<UserHealth> users = [];
  @override
  void initState() {
    super.initState();
    getusers();
  }

  getusers() async {
    print('rrrrr$users');
    users = await DBHelper.userHeathList(widget.userInfo!.email.toString());

    return users;
  }

  String pname = 'ahmed saeed';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      // if (int.parse((widget.data!.cholesterol.toString())) > 200) {

      if (pname == 'ahmed saeed') {
        print('Snack BarRRrrrrr 1111');
        var snackBar = const SnackBar(
          // duration: const Duration(milliseconds: 5000),
          content: Text(
            "Examination result: the patient have develop diabetes in the future",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        //print('Snack BarRRrrrrr  22222');
        var snackBar = const SnackBar(
            duration: Duration(milliseconds: 5000),
            content: Text(
                "Examination result: the patient does not develop diabetes in the future",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Diabetes Reading By Days'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                                  widget.userInfo!.firstName.toString(),
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
                              widget.userInfo!.gender.toString(),
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
                height: 350,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => FutureBuilder(
                      future: getusers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return TableContent(users, context);
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  itemCount: 1,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddUserHealth(userEmail: widget.userInfo!.email),
                    ),
                  );
                },
                icon: const Icon(
                    Icons.assignment_return), //icon data for elevated button
                label: const Text("Add Health Info"), //label text
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
      ),
    );
  }
}

List<TableRow> getList(List<UserHealth> users, BuildContext context) {
  int ishavediabetes = 0;
  int lastDrAdvaice = 0;
  List<TableRow> childs = [];
  for (var i in users) {
    lastDrAdvaice += 1;
    if (i.glucoserate! >= 200) {
      ishavediabetes += 1;
      if (ishavediabetes == 2) {
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
      child: Column(
        children: <Widget>[
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
                        Text(
                          'Doctor Advise',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                      Column(children: const [
                        Text('Action',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                    ]),
                    ...getList(users, context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


  


  

// FutureBuilder(
//                     future: getusers(),
//                     builder: (ctx, snapshot) {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) =>
//                               TableContent(users[index]),
//                           itemCount: users.length,
//                         );
//                       } else {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     }),