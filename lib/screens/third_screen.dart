// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dagnosis_and_prediction/model/User_Health_model.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  final UserHealth? data;
  const ThirdScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

//form key used for validation form
  final _formkey = GlobalKey<FormState>();

  // editing controller

  TextEditingController? highpressureEditingController;
  TextEditingController? lowerpressureEditingController;

  TextEditingController? cholesterolFieldditingController;

  TextEditingController? bloodglucoserateFieldditingController;

  @override
  void initState() {
    super.initState();
    print(widget.data);
    _controller = AnimationController(vsync: this);
    highpressureEditingController =
        TextEditingController(text: widget.data!.highbloodpressure.toString());
    lowerpressureEditingController =
        TextEditingController(text: widget.data!.lowerbloodpressure.toString());

    cholesterolFieldditingController =
        TextEditingController(text: widget.data!.cholesterol.toString());

    bloodglucoserateFieldditingController =
        TextEditingController(text: widget.data!.height.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
// Gender Dropdown list

// high pressure Name field

    final highpressureNameField = TextFormField(
      autofocus: false,
      controller: highpressureEditingController,
      keyboardType: TextInputType.number,

      // validator: (),

      onSaved: (value) {
        highpressureEditingController!.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.numbers),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "High Blood Pressure",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

// lower pressure Name field

    final lowerpressureNameField = TextFormField(
      autofocus: false,
      controller: lowerpressureEditingController,
      keyboardType: TextInputType.number,

      // validator: (),

      onSaved: (value) {
        lowerpressureEditingController!.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.numbers),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Lower Blood Pressure",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

// bloodglucoserate Name field

    // ignore: non_constant_identifier_names
    final TextFormField BloodglucoserateNameField = TextFormField(
      autofocus: false,
      controller: lowerpressureEditingController,
      keyboardType: TextInputType.number,

      // validator: (),

      onSaved: (value) {
        bloodglucoserateFieldditingController!.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.numbers),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Blood Glucose Rate",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

// SignUp Button

    final signUpBotton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "Print the Report",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

// cholesterol Field

    final CholesterolNameField = TextFormField(
      autofocus: false,
      controller: cholesterolFieldditingController,
      keyboardType: TextInputType.number,

      // validator: (),

      onSaved: (value) {
        cholesterolFieldditingController!.text = value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.numbers),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Cholesterol",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        // create arow navigator to home page
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 100,
                          child: Image.asset(
                            "assets/test.png",
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Blood Pressure :Hight and Low',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),
                      highpressureNameField,
                      const SizedBox(height: 15),
                      lowerpressureNameField,
                      const SizedBox(height: 15),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Cholesterol :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),
                      CholesterolNameField,
                      const SizedBox(height: 15),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Blood Glucose Rate :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),
                      BloodglucoserateNameField,
                      const SizedBox(height: 15),
                      signUpBotton,
                      const SizedBox(height: 15),
                    ]),
              ),
            ),
          )),
        ));
  }
}
