import 'package:dagnosis_and_prediction/Widget/custom_buttons.dart';
import 'package:dagnosis_and_prediction/Widget/custom_text_field.dart';
import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:dagnosis_and_prediction/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../model/location_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

//form key used for validation form
  final _formkey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isShadow = false;
//
  late Location location;
  // editing controller

  final cityNameEditingController = TextEditingController();
  final districtNameEditingController = TextEditingController();
  final streetNameEditingController = TextEditingController();
  final houseNameEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  // drob down List

// Select birthdate

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    location = Location(
      cityName: '',
      districtName: '',
      streetName: '',
      houseName: '',
    );
    userNameEditingController.text = 'Omar Aziz';
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  var selectCity = "Baghdad";

  @override
  Widget build(BuildContext context) {
// Gender Dropdown list

// SignUp Button
    bool _validateAndSave() {
      final form = _formkey.currentState;
      if (form!.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    final saveBotton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          FocusScope.of(context).unfocus();

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child: const Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 100,
                          child: Image.asset(
                            "assets/test.png",
                            fit: BoxFit.contain,
                          )),

                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'User Name :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          enabled: false,
                          controller: userNameEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.man),
                            // labelText: 'User Name',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'City Name :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        color: Colors.white,
                        child: DropdownButtonFormField(
                          iconSize: 40,
                          isExpanded: true,
                          items: [
                            "Baghdad",
                            "Basrah",
                            "Mosul",
                            "Erbil",
                            "Kirkuk",
                            "Najaf",
                            "Karbala",
                            "Nasiriyah",
                            "Al-Amarah",
                            "Al-Diwaniyah",
                            "Al-Kut",
                            "Al-Hillah",
                            "Dihok",
                            "Al-Ramadi",
                            "Al-Fallujah",
                            "Samarra",
                            "Al-Samawah",
                            "Baqubah",
                            "Tikrit",
                            "Al-Sulaimaniea",
                            "Dohouk"
                          ]
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectCity = val.toString();
                            });
                          },
                          value: selectCity,
                        ),
                      ),

                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'District Name :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      CustomTextField(
                        textform: "District Name",
                        icon: Icons.account_circle,
                        controller: districtNameEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Enter District Name",
                        onSavedfunction: (value) {
                          districtNameEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Street Name :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      CustomTextField(
                        textform: "Street Name",
                        icon: Icons.account_circle,
                        controller: streetNameEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Enter Street Name",
                        onSavedfunction: (value) {
                          streetNameEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'House Name :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      CustomTextField(
                        textform: "House Number",
                        icon: Icons.email,
                        controller: houseNameEditingController,
                        textInputType: TextInputType.emailAddress,
                        validatorMessge: "Please Enter House Number",
                        onSavedfunction: (value) {
                          houseNameEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 20),

                      //signUpBotton,
                      CustomButtons(
                        globalKey: _formkey,
                        buttontext: "Save",
                        fontWeight: FontWeight.normal,
                        function: () async {
                          FocusScope.of(context).unfocus();

                          if (_validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            // location.cityName =
                            //     cityNameEditingController.text;
                            location.districtName =
                                districtNameEditingController.text;
                            location.streetName =
                                streetNameEditingController.text;
                            houseNameEditingController.text =
                                houseNameEditingController.text;

                            // drob down list
                            location.cityName = selectCity;

                            // await DBHelper.inserttolocation(location).then((value) {
                            //   if (value > 0) {
                            //     var snackBar = const SnackBar(
                            //       content: Text("Insert Location Done"),
                            //     );
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar);
                            //     setState(() async {
                            //       isApiCallProcess = false;
                            //       //await DBHelper.query();
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => const LoginScreen(),
                            //         ),
                            //       );
                            //     });
                            //   }
                            // });
                          }
                        },
                      ),
                    ]),
              ),
            ),
          )),
        ));
  }
}
