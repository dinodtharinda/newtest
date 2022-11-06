//User Registation Login

// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_test/constants/routes.dart';
import 'package:new_test/utilities/show_dialogs.dart';

import '../firebase_options.dart';

// Error Message of SnackBar method

const delay = 2;
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
    Navigator.of(context).pushNamed(verifyEmailRoute);
    Future.delayed(const Duration(seconds: delay), () {
      loading(); //Button unPress Method call
    });
  } on FirebaseAuthException catch (e) {
    Future.delayed(const Duration(seconds: delay), () {
      showErrorMessage(errorMsg(e), context);
      loading();
    });
  } catch (e) {
    Future.delayed(const Duration(seconds: delay), () {
      showErrorMessage(e.toString(), context);
      loading();
    });
  }
}

void logIn(TextEditingController _email, TextEditingController _password,
    BuildContext context, Function loading) async {
  try {
    final email = _email.text;
    final password = _password.text;
    loading(); //Button unPress Method call
    sLoading(context);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(seconds: delay), () {
      loading(); //Button unPress Method call
    });
    Future.delayed(const Duration(seconds: delay), () {
      if (user?.emailVerified ?? false) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
      }
    });
  } on FirebaseAuthException catch (e) {
    Future.delayed(const Duration(seconds: delay), () {
      Navigator.of(context).pop();
      showErrorMessage(errorMsg(e), context);
      loading();
    });
  } catch (e) {
    Future.delayed(const Duration(seconds: delay), () {
      Navigator.of(context).pop();
      showErrorMessage(e.toString(), context);
      loading();
    });
  }
}

//Veriy Email Logic
void verifyEmail(BuildContext context, Function loading) async {
  try {
    loading(); //Button unPress Method call
    Future.delayed(const Duration(seconds: 3), () {
      loading(); //Button unPress Method call
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
    showLoading(context);

    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  } on FirebaseAuthException catch (e) {
    showErrorMessage(e.code, context);
  } catch (e) {
    showErrorMessage(e.toString(), context);
  }
}

//Restart
void restart(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    showLoading(context);
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(loginRoute, (route) => false);
    });
  } catch (e) {
    showErrorMessage(e.toString(), context);
  }
}

//Log out
void logout(BuildContext context) async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance.signOut();
    showLoading(context);
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(loginRoute, (route) => false);
    });
  } catch (e) {
    showErrorMessage(e.toString(), context);
  }
}
