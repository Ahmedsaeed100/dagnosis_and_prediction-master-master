import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  final String textform;
  final IconData icon;
  final String validatorMessge;
  final TextInputType textInputType;

  final void Function(String?)? onSavedfunction;

  CustomTextField({
    Key? key,
    this.controller,
    required this.textform,
    required this.icon,
    required this.validatorMessge,
    required this.textInputType,
    required this.onSavedfunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool visibility = true;

    // This if condition Make when text form is password
    textform.contains('Password') ? visibility = true : visibility = false;
    return TextFormField(
      validator: (value) {
        print(value);
        if (textform.contains('advise') && value == '') {
          value = 'none';
        } else if (value == '') {
          return validatorMessge;
        } else if (textform.contains('Email') &&
            (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!))) {
          // Check if Email Address wright Correctly
          return 'Please Enter Correct Email Address';
          // check Password
        } else if (textform.contains('password') && value!.length < 6) {
          return 'Password at least contains 6 character';
        }

        return null;
      },
      onSaved: onSavedfunction,
      keyboardType: textInputType,
      controller: controller,
      autofocus: false,
      textInputAction: TextInputAction.next,
      obscureText: visibility,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
            color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: textform,
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 3)),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 5),
        ),
      ),
    );
  }
}
