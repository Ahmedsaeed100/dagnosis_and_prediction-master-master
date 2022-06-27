import 'package:dagnosis_and_prediction/Widget/custom_buttons.dart';
import 'package:dagnosis_and_prediction/Widget/custom_text_field.dart';
import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/User_Health_model.dart';
import 'package:dagnosis_and_prediction/model/collection.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:dagnosis_and_prediction/screens/registration_screen.dart';
import 'package:dagnosis_and_prediction/screens/add_User_Health.dart';
import 'package:dagnosis_and_prediction/screens/user_cases_screen.dart';
import 'package:dagnosis_and_prediction/screens/admin_screen.dart';

import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

//form key used for validation form
  final _formkey = GlobalKey<FormState>();
  bool isPassword = true;
  late Registration registration;
  bool isApiCallProcess = false;

// editing controller

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

// FireBase

  // final _auth = FirebaseAuth.instance;

// SignUp Button
  bool _validateAndSave() {
    final form = _formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    //DBHelper.healthQuery();
    registration = Registration(
      email: '',
      password: '',
    );
  }

  late List<Collection> users;
  getusers() async {
    users = await DBHelper.getcolliction();
    return users;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                        ),
                      ),

                      const SizedBox(height: 45),
                      //Start emailField,

                      CustomTextField(
                        textform: "Email",
                        icon: Icons.email,
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        validatorMessge: "Please Enter Your Email",
                        onSavedfunction: (value) {
                          emailController.text = value!;
                        },
                      ),
                      // End Email Field
                      const SizedBox(height: 25),
                      //Start passwordField,

                      TextPasswordField(
                        controller: passwordController,
                        texttype: TextInputType.visiblePassword,

                        sufixPressed: () {
                          // print('here');
                          setState(() {
                            isPassword = !isPassword;
                            print('here');
                          });
                        },
                        onSubmit: (value) {
                          // print('KKKKK');
                        },
                        onChange: (value) {
                          //print('KKKKK');
                        },
                        // onSaved: (String value) {
                        //   passwordController.text = value;
                        // },
                        lableText: 'Password',
                        prefixIcon: Icons.lock,
                        suffixIcon: isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        isPassword: isPassword,
                        //End Password field
                      ),
                      // End Password Field
                      const SizedBox(height: 35),
                      //loginBotton,
                      //signUpBotton,
                      CustomButtons(
                        globalKey: _formkey,
                        buttontext: "LOGIN",
                        fontWeight: FontWeight.normal,
                        function: () async {
                          FocusScope.of(context).unfocus();

                          if (_validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            registration.firstName = emailController.text;
                            registration.secondName = passwordController.text;

                            isApiCallProcess = false;
                            Registration? data = await DBHelper.getLogin(
                              emailController.text,
                              passwordController.text,
                            );

                            UserHealth? userhasaddHealth =
                                await DBHelper.checkUserHasHeathState(
                              emailController.text,
                            );
                            //  print('ssssssssss ${data!.highbloodpressure}');
                            if (data == null) {
                              var snackBar = const SnackBar(
                                content: Text("Email Or Password not correct"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              //  print(data);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // check if user is admin or Not regster his Health data yat or go to fill data
                                    builder: (context) {
                                  if (data.email == 'omar@gmail.com') {
                                    return AdminScreen();
                                  } else if (userhasaddHealth
                                          ?.highbloodpressure ==
                                      null) {
                                    return AddUserHealth(userEmail: data.email);
                                  } else {
                                    getusers();
                                    return UserCasseScreen(
                                      userInfo: data,
                                    );
                                  }
                                }),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ])
                    ]),
              ),
            ),
          )),
        ));
  }

// LogIn Function

//   void LogIn(String email, String pass) async {
//     if (_formkey.currentState!.validate()) {
//       await _auth
//           .signInWithEmailAndPassword(email: email, password: pass)
//           .then((uid) => {
//                 Fluttertoast.showToast(msg: 'Login Sucsusfull'),
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => UserInformation()))
//               })
//           .catchError((Error) {
//         Fluttertoast.showToast(msg: Error!.message);
//       });
//     }
//   }
// }
}
