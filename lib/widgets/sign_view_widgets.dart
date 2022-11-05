//Login Button Widget
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:new_test/constants/routes.dart';

Widget signBtn(
  String btnTitle,
  Function sign,
  TextEditingController _email,
  TextEditingController _password,
  BuildContext context,
  Function loading,
  bool unPress,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: Card(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.black38,
        onTap:
            (unPress) ? () => sign(_email, _password, context, loading) : null,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: unPress
                ? Text(
                    btnTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget textfield(String hint, TextEditingController controller, bool obscure) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        style: const TextStyle(fontSize: 18),
        cursorColor: Colors.deepPurple,
        cursorHeight: 20,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    ),
  );
}

Widget accountOption(
    String reson, String btnTitle, BuildContext context, Function loading) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        reson,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      TextButton(
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
        onPressed: () {
          loading(); //Button unPress Method call
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.of(context).pushNamedAndRemoveUntil(
              btnTitle == 'Login here' ? loginRoute : registerRoute,
              (route) => false);
        },
        child: Text(
          btnTitle,
          style: const TextStyle(
              color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget signHeader(String title, String subtitle) {
  return Column(
    children: [
      Text(
        title, //Head
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        subtitle,
        style: const TextStyle(fontSize: 20), //title
      ),
    ],
  );
}

//Text Button
Widget textButton(
  String btnTitle,
  Function function,
) {
  return TextButton(
    style: ButtonStyle(
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
    ),
    onPressed: () {
      function();
    },
    child: Text(
      btnTitle,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
    ),
  );
}
