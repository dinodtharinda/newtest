// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();

    super.dispose();
  }

  bool unPress = true;

  SnackBar message(
    Color color,
    String msg,
  ) {
    return SnackBar(
        content: Text(msg),
        elevation: 16,
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ));
  }

  Widget textfield(
      String hint, TextEditingController controller, bool obscure) {
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
          style: TextStyle(fontSize: 18),
          cursorColor: Colors.deepPurple,
          cursorHeight: 20,
          decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        ),
      ),
    );
  }

  void logIn() async {
    final email = _email.text;
    final password = _password.text;
    loading(); //Button unPress Method call
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Future.delayed(Duration(seconds: 3), () {
        loading(); //Button unPress Method call
      });
      SnackBar snackbar = message(
          Color.fromARGB(255, 105, 244, 54), 'Success!'); //snackBar widget call
      Future.delayed(Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    } on FirebaseAuthException catch (e) {
      SnackBar snackbar = message(
          Color.fromARGB(255, 244, 54, 54), errorMsg(e)); //snackBar widget call
      Future.delayed(Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    } catch (e) {
      SnackBar snackbar = message(Color.fromARGB(255, 244, 54, 54),
          e.toString()); //snackBar widget call
      Future.delayed(Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    }
  }

// Error Message of SnackBar method
  String errorMsg(FirebaseAuthException e) {
    var errorMsg = e.code;
    if (e.code == 'user-not-found') {
      errorMsg = 'User not found!';
    } else if (e.code == 'unknown') {
      errorMsg = 'Please enter Email and Password!';
    } else if (e.code == 'wrong-password') {
      errorMsg = 'Wrong password!';
    } else if (e.code == 'invalid-email') {
      errorMsg = 'Invalid Email!';
    } else if (e.code == 'too-many-requests') {
      errorMsg = 'Please try again later!';
    } else if (e.code == 'network-request-failed') {
      errorMsg = 'Please Connect Network';
    } else {
      errorMsg = e.code;
    }
    return errorMsg;
  }

//Login Button Widget
  Widget loginBtn(String btnTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Card(
        color: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.black38,
          onTap: (unPress) ? logIn : null,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: unPress
                  ? Text(
                      btnTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : SizedBox(
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

  //Button unPress Logic
  void loading() {
    setState(() {
      if (unPress == false) {
        unPress = true;
      } else {
        unPress = false;
      }
    });
  }

  //if you Not a Member
  Widget notMember(String reson, String btnTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          reson,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onPressed: () {
            loading(); //Button unPress Method call
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/register/', (route) => false);
          },
          child: Text(
            btnTitle,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //hello again
            Text(
              'New Test', //Head
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(fontSize: 20), //title
            ),
            SizedBox(
              height: 80,
            ),
            textfield('Email', _email, false), //email textfield
            SizedBox(
              height: 10,
            ),
            textfield('Password', _password, false), //password Textfield
            SizedBox(
              height: 10,
            ),

            loginBtn('Login'), //LogIn button
            SizedBox(
              height: 25,
            ),
            notMember(
                'Not a Member?', 'Register Now'), //not a member? Register Now
          ]),
        ),
      ),
    );
  }
}
