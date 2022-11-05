import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_test/firebase_options.dart';

import '../user_auth.dart';
import '../utilities/show_dialogs.dart';
import '../widgets/sign_view_widgets.dart';

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
                  textButton(
                    'Send email verification',
                    () => verifyEmail(context, loading),
                  ),
                  textButton(
                    'Restart',
                    () => restart(context),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
