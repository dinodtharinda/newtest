//User Registation Login

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_test/constants/routes.dart';
import 'package:new_test/utilities/show_error_message.dart';

import 'firebase_options.dart';

// Error Message of SnackBar method
String errorMsg(FirebaseAuthException e) {
  var errorMsg = e.code;
  if (e.code == 'user-not-found') {
    errorMsg = 'User not found!';
  } else if (e.code == 'unknown') {
    errorMsg = 'Please enter Email and Password!';
  } else if (e.code == 'email-already-in-use') {
    errorMsg = 'This email is already in use!';
  } else if (e.code == 'invalid-email') {
    errorMsg = 'Invalid Email!';
  } else if (e.code == 'weak-password') {
    errorMsg = 'Weak password!';
  } else if (e.code == 'too-many-requests') {
    errorMsg = 'Please try again later!';
  } else if (e.code == 'network-request-failed') {
    errorMsg = 'Please Connect Network';
  } else if (e.code == 'user-not-found') {
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

void register(TextEditingController _email, TextEditingController _password,
    BuildContext context, Function loading) async {
  try {
    final email = _email.text;
    final password = _password.text;
    loading(); //Button unPress Method call
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    Future.delayed(const Duration(seconds: 3), () {
      loading(); //Button unPress Method call
    });
  } on FirebaseAuthException catch (e) {
    Future.delayed(const Duration(seconds: 3), () {
      showErrorMessage(errorMsg(e), context);
      loading();
    });
  } catch (e) {
    Future.delayed(const Duration(seconds: 3), () {
      showErrorMessage(e.toString(), context);
      loading();
    });
  }
}

void logIn(TextEditingController _email, TextEditingController _password,
    BuildContext context, Function loading) async {
  final email = _email.text;
  final password = _password.text;
  loading(); //Button unPress Method call
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Future.delayed(const Duration(seconds: 2), () {
      loading(); //Button unPress Method call
    });
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
    });
  } on FirebaseAuthException catch (e) {
    Future.delayed(const Duration(seconds: 3), () {
      showErrorMessage(errorMsg(e), context);
      loading();
    });
  } catch (e) {
    Future.delayed(const Duration(seconds: 3), () {
      showErrorMessage(e.toString(), context);
      loading();
    });
  }
}
