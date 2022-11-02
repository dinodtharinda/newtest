import 'package:flutter/material.dart';
import 'package:new_test/views/login_view.dart';

void main() {
  runApp(
    const MaterialApp(
      home: LoginView(),
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
