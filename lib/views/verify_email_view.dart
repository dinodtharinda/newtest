import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/firebase_options.dart';

class VerityEmailView extends StatefulWidget {
  const VerityEmailView({Key? key}) : super(key: key);

  @override
  State<VerityEmailView> createState() => _VerityEmailViewState();
}

class _VerityEmailViewState extends State<VerityEmailView> {
  bool press = true;

//Text
  Widget text(String title, double fs, FontWeight fw) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fs,
        fontWeight: fw,
      ),
    );
  }

  // SnackBar widget (Error msg snack and Succes msg snack)
  SnackBar message(Color color, String msg) {
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
      ),
    );
  }

//Text Button
  Widget textButton(String btnTitle) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      onPressed: press ? verifyEmail : null,
      child: (press)
          ? Text(
              btnTitle,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            )
          : const CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
    );
  }

  //Button unPress Logic
  void loading() {
    setState(() {
      if (press == false) {
        press = true;
      } else {
        press = false;
      }
    });
  }

  //Veriy Email Logic
  void verifyEmail() async {
    loading(); //Button unPress Method call
    Future.delayed(const Duration(seconds: 3), () {
      loading(); //Button unPress Method call
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        SnackBar snackbar = message(const Color.fromARGB(255, 244, 54, 54),
            e.toString()); //snackBar widget call
        delay(ScaffoldMessenger.of(context).showSnackBar(snackbar));//delay
      }
    }
  }

  //delay
  Future delay(Object work) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
       work;
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text('Verify Your Email', 45, FontWeight.bold),
                  const SizedBox(
                    height: 100,
                  ),
                  text('Please Verify your email', 15, FontWeight.normal),
                  textButton('Send email verification'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
