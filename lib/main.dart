
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/constants/routes.dart';
import 'package:new_test/views/home_view.dart';
import 'package:new_test/views/login_view.dart';
import 'package:new_test/views/register_view.dart';
import 'firebase_options.dart';
import 'views/verify_email_view.dart';

void main() {
  runApp(
    MaterialApp(
      home: const MyApp(),
      routes: {
        registerRoute: (context) => const RegisterView(),
        loginRoute: (context) => const LoginView(),
        homeRoute: (context) => const HomePage(),
        verifyEmailRoute: (context) => const VerityEmailView() 
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const LoginView();
              } else {
                return const VerityEmailView();
              }
            }
            return const RegisterView();
          default:
            return const CircularProgressIndicator(
              color: Colors.deepPurple,
            );
        }
      },
    );
  }
}
