import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:dagnosis_and_prediction/screens/tableresualt.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late List<Registration> users;
  @override
  void initState() {
    super.initState();
    getusers();
  }

  getusers() async {
    users = await DBHelper.getuserlist();
    print('tttttttttttt ${users.first.firstName}');
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getusers(),
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //   print('ssssssssssss${snapshot.data[0]('firstName')}');
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: ((context, i) {
                  print('ssssssssssss${users[i].email}');
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.redAccent,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TableResualt()));
                        },
                        child: Text(
                          '${users[i].email}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
