import 'package:dagnosis_and_prediction/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final logOutBotton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        // minWidth: MediaQuery.of(context).size.width,
        minWidth: 150,

        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },

        // child: Text(
        //   "LogOut",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),

        // ),

        child: ElevatedButton.icon(
          onPressed: () {
            // print("You pressed Icon Elevated Button");

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          icon: Icon(Icons.logout), //icon data for elevated button
          label: Text("LogOut"), //label text
          style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(
                  255, 255, 68, 68) //elevated btton background color
              ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/test.png", fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Name",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500)),
              Text("Email",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 15,
              ),
              SizedBox(height: 15),
              logOutBotton,

              // ActionChip(label: Text("LogOut"), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
