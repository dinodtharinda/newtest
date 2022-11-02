import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/firebase_options.dart';

class VerityEmailView extends StatefulWidget {
  const VerityEmailView({Key? key}) : super(key: key);

  @override
  State<VerityEmailView> createState() => _VerityEmailViewState();
}

bool press = true;

class _VerityEmailViewState extends State<VerityEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future:   Firebase.initializeApp(
                        options: DefaultFirebaseOptions.currentPlatform),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify Your email',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Please Verify your email',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () async {
                    setState(() {
                      if (press == true) {
                        press = false;
                      }
                    });
                    Future.delayed(Duration(seconds: 3), () {
                      setState(() {
                        if (press == false) {
                          press = true;
                        }
                      });
                    });
               
                     final  user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      try {
                        await user.sendEmailVerification();
                      } catch (e) {
                        var snackbar = SnackBar(
                            content: Text(e.runtimeType.toString()),
                            elevation: 16,
                            backgroundColor: Color.fromARGB(192, 171, 0, 0),
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
                        Future.delayed(Duration(seconds: 3), () {
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        });
                      }
                    }
                  },
                  child: (press)
                      ? const Text(
                          'Send email verification',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ))
            ],
          ),
        );
          },
        ),
      ),
    );
  }
}
