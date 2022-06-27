// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dagnosis_and_prediction/Widget/custom_buttons.dart';
import 'package:dagnosis_and_prediction/Widget/custom_text_field.dart';
import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../model/User_Health_model.dart';

class AddUserHealth extends StatefulWidget {
  final String? userEmail;
  const AddUserHealth({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<AddUserHealth> createState() => _AddUserHealthState();
}

class _AddUserHealthState extends State<AddUserHealth>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

//form key used for validation form
  final _formkey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isShadow = false;
//
  late UserHealth _userHealth;
  // editing controller

  final emailEditingController = TextEditingController();
  final highpressureEditingController = TextEditingController();
  final lowerpressureEditingController = TextEditingController();

  final weightFieldditingController = TextEditingController();
  final heightFieldditingController = TextEditingController();

  // drob down List
  final medicineController = TextEditingController();
  final diabetesinfamilyController = TextEditingController();

  final cholesterolFieldditingController = TextEditingController();
  final medicineFieldditingController = TextEditingController();

  final bloodGlucoseRateController = TextEditingController();

  final dietFoodAdviseController = TextEditingController();
  final medicineAdviseController = TextEditingController();
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
    _controller = AnimationController(vsync: this);
    //  print('rrrrrrrrrrr ${widget.userEmail}');
    _userHealth = UserHealth(
      email: widget.userEmail,
      highbloodpressure: 0,
      lowerbloodpressure: 0,
      weight: 0,
      height: 0,
      cholesterol: 0,
      medicine: 'None',
      diabetesinfamily: 'No',
      date: '',
      glucoserate: 0,
      skinfoldthickness: 0.0,
      doctoradvise: '',
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
                    children: [
                      SizedBox(
                          height: 100,
                          child: Image.asset(
                            "assets/test.png",
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 45),
                      Text(widget.userEmail.toString()),
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
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      CustomTextField(
                        textform: "High Blood Pressure",
                        icon: Icons.numbers,
                        controller: highpressureEditingController,
                        textInputType: TextInputType.number,
                        validatorMessge:
                            "Please Enter Your High Blood Pressure",
                        onSavedfunction: (value) {
                          highpressureEditingController.text = value!;
                        },
                      ),

                      const SizedBox(height: 15),
                      CustomTextField(
                        textform: "Lower Blood Pressure",
                        icon: Icons.numbers,
                        controller: lowerpressureEditingController,
                        textInputType: TextInputType.number,
                        validatorMessge:
                            "Please Enter Your Lower Blood Pressure",
                        onSavedfunction: (value) {
                          lowerpressureEditingController.text = value!;
                        },
                      ),

                      const SizedBox(height: 15),

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Weight and Height :',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),

                      CustomTextField(
                        textform: "Weight",
                        icon: Icons.numbers,
                        controller: weightFieldditingController,
                        textInputType: TextInputType.number,
                        validatorMessge: "Please Enter Weight",
                        onSavedfunction: (value) {
                          weightFieldditingController.text = value!;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        textform: "Height",
                        icon: Icons.numbers,
                        controller: heightFieldditingController,
                        textInputType: TextInputType.number,
                        validatorMessge: "Please Enter Height",
                        onSavedfunction: (value) {
                          heightFieldditingController.text = value!;
                        },
                      ),

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

                      CustomTextField(
                        textform: "Cholesterol",
                        icon: Icons.numbers,
                        controller: cholesterolFieldditingController,
                        textInputType: TextInputType.number,
                        validatorMessge: "Please Enter Cholesterol",
                        onSavedfunction: (value) {
                          cholesterolFieldditingController.text = value!;
                        },
                      ),

                      //Start Medicen Drop Down

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                          top: 25,
                        ),
                        child: const Text(
                          'Medicine Selection :',
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
                          hint: const Text('HHH'),
                          iconSize: 40,
                          isExpanded: true,
                          items: ["None", "Tablet", "Injiction"]
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectMedicine = val.toString();
                            });
                          },
                          value: selectMedicine,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                        width: 300,
                      ),

                      // End Medicen Drop Dwon

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Diabetes in the family :',
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
                          hint: const Text('HHH'),
                          iconSize: 40,
                          isExpanded: true,
                          items: ["Yes", "No"]
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectDiabetesinFamily = val.toString();
                            });
                          },
                          value: selectDiabetesinFamily,
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        textform: "Blood Glucose rate",
                        icon: Icons.bloodtype,
                        controller: bloodGlucoseRateController,
                        textInputType: TextInputType.text,
                        validatorMessge: "Blood Glucose rate",
                        onSavedfunction: (value) {
                          bloodGlucoseRateController.text = value!;
                        },
                      ),
                      const SizedBox(height: 30),

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
                      const SizedBox(height: 30),
                      CustomTextField(
                        textform: "Diet food advise",
                        icon: Icons.food_bank,
                        controller: dietFoodAdviseController,
                        textInputType: TextInputType.text,
                        validatorMessge: "",
                        onSavedfunction: (value) {
                          dietFoodAdviseController.text = value!;
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        textform: "Medicine advise",
                        icon: Icons.medical_information,
                        controller: medicineAdviseController,
                        textInputType: TextInputType.text,
                        validatorMessge: "",
                        onSavedfunction: (value) {
                          medicineAdviseController.text = value!;
                        },
                      ),
                      const SizedBox(height: 30),
                      //signUpBotton,
                      CustomButtons(
                        globalKey: _formkey,
                        buttontext: "Add Data",
                        fontWeight: FontWeight.normal,
                        function: () {
                          FocusScope.of(context).unfocus();
                          print("${selectedDate.toLocal()}".split(' ')[0]);
                          if (_validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            _userHealth.highbloodpressure =
                                int.parse(highpressureEditingController.text);
                            _userHealth.lowerbloodpressure =
                                int.parse(lowerpressureEditingController.text);
                            _userHealth.weight =
                                int.parse(weightFieldditingController.text);
                            _userHealth.height =
                                int.parse(heightFieldditingController.text);
                            _userHealth.cholesterol = int.parse(
                                cholesterolFieldditingController.text);

                            ///
                            _userHealth.glucoserate =
                                int.parse(bloodGlucoseRateController.text);

                            _userHealth.date =
                                "${selectedDate.toLocal()}".split(' ')[0];

                            _userHealth.doctoradvise =
                                dietFoodAdviseController.text;

                            ///
                            // drob down list
                            _userHealth.medicine = selectMedicine;
                            _userHealth.diabetesinfamily =
                                selectDiabetesinFamily;

                            DBHelper.insertUserHealth(_userHealth)
                                .then((value) {
                              if (value > 0) {
                                var snackBar = const SnackBar(
                                  content: Text("Add User Health is Done"),
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
                                  content: Text("Something Wrong"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              // ignore: unnecessary_null_comparison//
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
