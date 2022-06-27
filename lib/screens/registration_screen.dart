import 'package:dagnosis_and_prediction/Widget/custom_buttons.dart';
import 'package:dagnosis_and_prediction/Widget/custom_text_field.dart';
import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:dagnosis_and_prediction/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

//form key used for validation form
  final _formkey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isShadow = false;
//
  late Registration registration;
  // editing controller

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final nickeNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  // drob down List
  final genderController = TextEditingController();

// Select birthdate
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
        // ${selectedDate.toLocal()}".split(' ')[0]
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLoaction();
    _controller = AnimationController(vsync: this);
    registration = Registration(
      firstName: '',
      secondName: '',
      nikeName: '',
      email: '',
      password: '',
      gender: 'Male',
      birthdate: '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  var selectGender = "Male";

  var selectMedicine = "None";

  var selectDiabetesinFamily = "No";

  double latitude = 0.0;
  double longitude = 0.0;

  void getCurrentLoaction() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // var lastPostion = await Geolocator.getLastKnownPosition();
    // print(lastPostion);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

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

    final signUpBotton = Material(
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
          "SignUp",
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
              padding: const EdgeInsets.all(36.0),
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
                      Text("${latitude} , ${longitude}"),
                      const SizedBox(height: 45),
                      CustomTextField(
                        textform: "First Name",
                        icon: Icons.account_circle,
                        controller: firstNameEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Enter Your Name",
                        onSavedfunction: (value) {
                          firstNameEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        textform: "Second Name",
                        icon: Icons.account_circle,
                        controller: secondNameEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Enter Your Name",
                        onSavedfunction: (value) {
                          secondNameEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        textform: "Nike Name",
                        icon: Icons.account_circle,
                        controller: nickeNameEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Enter Your Name",
                        onSavedfunction: (value) {
                          nickeNameEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        textform: "Email",
                        icon: Icons.email,
                        controller: emailEditingController,
                        textInputType: TextInputType.emailAddress,
                        validatorMessge: "Please Enter Your Email",
                        onSavedfunction: (value) {
                          emailEditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        textform: "Password",
                        icon: Icons.vpn_key,
                        controller: passwordEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Enter Your Email",
                        onSavedfunction: (value) {
                          passwordEditingController.text = value!;
                        },
                      ),

                      const SizedBox(height: 20),
                      CustomTextField(
                        textform: "Confirm Password",
                        icon: Icons.vpn_key,
                        controller: confirmPasswordEditingController,
                        textInputType: TextInputType.name,
                        validatorMessge: "Please Confirm Your password",
                        onSavedfunction: (value) {
                          confirmPasswordEditingController.text = value!;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Start Gender Drop down
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Gender :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                      ),

                      const SizedBox(
                        height: 1,
                        width: 300,
                      ),
                      Container(
                        width: 200,
                        color: Colors.white,
                        child: DropdownButtonFormField(
                          iconSize: 40,
                          isExpanded: true,
                          items: ["Male", "Female"]
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectGender = val.toString();
                            });
                          },
                          value: selectGender,
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                        width: 300,
                      ),
                      //End  Gender Drop down Birth Date

                      // birth Date
                      InkWell(
                        onTap: () {
                          isShadow = true;
                          _selectDate(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isShadow != true
                                  ? Colors.grey
                                  : Colors.redAccent,
                              width: isShadow != true ? 0.5 : 1.7,
                            ),
                            boxShadow: [
                              isShadow != true
                                  ? const BoxShadow(
                                      color: Colors.grey, blurRadius: 0.7)
                                  : const BoxShadow(
                                      color: Colors.redAccent, blurRadius: 0.7),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      //signUpBotton,
                      CustomButtons(
                        globalKey: _formkey,
                        buttontext: "SIGN UP",
                        fontWeight: FontWeight.normal,
                        function: () {
                          FocusScope.of(context).unfocus();
                          print("${selectedDate.toLocal()}".split(' ')[0]);
                          if (_validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            registration.firstName =
                                firstNameEditingController.text;
                            registration.secondName =
                                secondNameEditingController.text;
                            registration.nikeName =
                                nickeNameEditingController.text;
                            registration.email = emailEditingController.text;
                            registration.password =
                                passwordEditingController.text;

                            registration.birthdate =
                                "${selectedDate.toLocal()}".split(' ')[0];

                            // drob down list
                            registration.gender = selectGender;

                            // latlng
                            registration.latitude = '$latitude';
                            registration.longitude = '$longitude';

                            DBHelper.userRegistration(registration)
                                .then((value) {
                              if (value > 0) {
                                var snackBar = const SnackBar(
                                  content: Text("Registration Done"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                setState(() async {
                                  isApiCallProcess = false;
                                  //await DBHelper.query();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                });
                              } else {
                                var snackBar = const SnackBar(
                                  content: Text("These Email Allready Exist"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              // ignore: unnecessary_null_comparison
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                    ]),
              ),
            ),
          )),
        ));
  }
}
