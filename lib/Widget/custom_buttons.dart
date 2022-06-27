import 'package:flutter/material.dart';

// this Custom Button To all Project
class CustomButtons extends StatelessWidget {
  const CustomButtons({
    Key? key,
    required GlobalKey<FormState> globalKey,
    required this.buttontext,
    required this.function,
    required this.fontWeight,
  })  : _globalKey = globalKey,
        super(key: key);

  final GlobalKey<FormState> _globalKey;
  final String buttontext;
  final Function function;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width - 100,
        onPressed: () {
          // Valdiate if data correct
          function();
        },
        child: Text(
          buttontext,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
