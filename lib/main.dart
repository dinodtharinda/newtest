
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/views/home_view.dart';
import 'package:new_test/views/login_view.dart';
import 'package:new_test/views/register_view.dart';
import 'firebase_options.dart';
import 'views/verify_email_view.dart';

void main() {
  runApp(
    MaterialApp(
      home: const HomePage(),
      routes: {
        '/register/': (context) => const RegisterView(),
        '/login/': (context) => const LoginView(),
        '/home/': (context) => const HomePage(),
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
