import 'package:flutter/material.dart';
import 'package:new_test/views/login_view.dart';
import 'package:new_test/views/register_view.dart';

void main() {
  runApp(
     MaterialApp(
      home:const RegisterView(),
      routes: {
        '/register/' :(context) => const RegisterView(),
        '/login/':(context) =>const LoginView()
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Hiii'),
    );
  }
}
