// ignore_for_file: prefer_const_constructors, use_build_context_synchronously



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

  bool press = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //hello again
            Text(
              'New Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 80,
            ),
            //email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _email,
                  style: TextStyle(fontSize: 18),
                  cursorColor: Colors.deepPurple,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                  ),
                ),
              ),
            ),
            //password Textfield
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _password,
                  cursorColor: Colors.deepPurple,
                  cursorHeight: 20,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //sign in button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Card(
                color: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Colors.black38,
                  onTap: (press)
                      ? () async {
                          final email = _email.text;
                          final password = _password.text;
                          setState(() {
                            if (press) {
                              press = false;
                            }
                          });
                          if (press == false) {}
                          await Firebase.initializeApp(
                              options: DefaultFirebaseOptions.currentPlatform);
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            var snackbar = SnackBar(
                                content: Text("Logged In!"),
                                elevation: 16,
                                backgroundColor:
                                    Color.fromARGB(144, 15, 234, 114),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                duration: const Duration(seconds: 10),
                                action: SnackBarAction(
                                  label: 'Dismiss',
                                  textColor: Colors.black,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } on FirebaseAuthException catch (e) {
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
                            var snackbar = SnackBar(
                                content: Text(errorMsg),
                                elevation: 16,
                                backgroundColor:
                                    Color.fromARGB(138, 234, 15, 15),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                duration: const Duration(seconds: 10),
                                action: SnackBarAction(
                                  label: 'Dismiss',
                                  textColor: Colors.black,
                                  onPressed: () {
                                    try {
                                      setState(() {
                                        if (press == false) {
                                          press = true;
                                        }
                                      });
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } catch (e) {
                            var snackbar = SnackBar(
                                content: Text(e.toString()),
                                elevation: 16,
                                backgroundColor:
                                    const Color.fromARGB(255, 234, 15, 15),
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                duration: const Duration(seconds: 10),
                                action: SnackBarAction(
                                  label: 'Dismiss',
                                  textColor: Colors.black,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  },
                                ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: press
                          ? Text(
                              'Login',
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
            ),
            SizedBox(
              height: 25,
            ),
            //not a member? Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/register/', (route) => false);
                  },
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
