import 'package:flutter/material.dart';

// import 'package:flutter_svg/flutter_svg.dart';

// ignore: non_constant_identifier_names
Widget TextEmailField({
  bool isPassword = false,

  // bool obscureText = false,
  required TextEditingController controller,
  required TextInputType texttype,
  required Function onSubmit,
  required Function onChange,
  // required Function onSaved,
  Color errorStylecolor = Colors.red,
  required String lableText,
  required IconData prefixIcon,
  // Function()? validated,
// for Password Field
  // required String validationemailempty,
  // required String validationemailformat,
  IconData? suffixIcon,
}) =>
    TextFormField(
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     //  return ('Please email Must be not Empty');
      //     return validationemailempty;
      //   }
      //   if (!RegExp(
      //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      //       .hasMatch(value)) {
      //     // return ('Please enter Correct email');
      //     return validationemailformat;
      //   }

      //   return null;
      // },

      validator: (value) {
        if (value == null || value.isEmpty) {
          return ('Please email Must be not Empty');
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ('Please enter Correct email');
        }

        return null;
      },
      // onSaved: onSaved(),
      controller: controller,
      keyboardType: texttype,
      // عند الضعط على زر نفذ
      // onFieldSubmitted: onSubmit(),
      obscureText: isPassword,

      // اثناء الباعة
      // onChanged: onChange(),
      decoration: InputDecoration(
        // labelStyle: TextStyle(
        //   color: Colors.blue,
        // ),

        // fillColor: Colors.orange, filled: true,

        errorStyle: TextStyle(
            color: errorStylecolor, fontSize: 20, fontWeight: FontWeight.bold),

        // hintText: 'Email Adress',
        labelText: lableText,
        // border: InputBorder.none,
        border: const OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorStylecolor, width: 3)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorStylecolor, width: 5),
        ),

        prefixIcon: Icon(prefixIcon),
// For Password field

        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );

// ignore: non_constant_identifier_names
Widget TextPasswordField({
  // value = null,
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType texttype,
  required Function onSubmit,
  required Function onChange,
  // Function? onSaved,
  Color errorStylecolor = Colors.red,
  required String lableText,
  required IconData prefixIcon,
  required Function sufixPressed,
  // required Function validateText,
  // required String validationpasswordempty,
  // required String validationpasswordfourcharcters,
  // required Function(String?)? validate,
// for Password Field

  required IconData suffixIcon,
}) =>
    TextFormField(
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Password must be not Empty';
        }
        if (!RegExp(r'^.{3,}$').hasMatch(value)) {
          return ('Enter valid pass (Min. 3 Char)');
          // return validationemailformat;
        }
        return null;
      },
      controller: controller,
      keyboardType: texttype,
      obscureText: isPassword,
      // onSaved: onSaved!(),
      decoration: InputDecoration(
        // labelStyle: TextStyle(
        //   color: Colors.blue,
        // ),

        // fillColor: Colors.orange, filled: true,

        errorStyle: TextStyle(
            color: errorStylecolor, fontSize: 20, fontWeight: FontWeight.bold),

        // hintText: 'Email Adress',
        labelText: lableText,

        // border: InputBorder.none,
        border: const OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorStylecolor, width: 3)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorStylecolor, width: 5),
        ),

        prefixIcon: Icon(prefixIcon),
// For Password field

        // ignore: unnecessary_null_comparison
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () {
                  sufixPressed();
                },
                icon: Icon(suffixIcon))
            : null,
      ),
    );
