// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:new_test/firebase/user_auth.dart';
import 'dart:developer' as devtools show log;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum MenuAction { logout, more }

class _HomePageState extends State<HomePage> {
//show message dialog
  Future<bool> showMessageDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('LogOut'),
            content: const Text('Are you sure you want to Log Out'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        }).then((value) => value ?? false);
  }

//Popup Menu Button
  Widget popUpMenu() {
    return PopupMenuButton<MenuAction>(
        icon: const Icon(
          Icons.more_vert_sharp,
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onSelected: (value) async {
          switch (value) {
            case MenuAction.logout:
              final shouldLogout =
                  await showMessageDialog(); //call show message dialog widgit
              devtools.log(shouldLogout.toString());
              if (shouldLogout) {
                logout(context);
              }
              break;
            case MenuAction.more:
              break;
          }
        },
        itemBuilder: (context) {
          return const [
            PopupMenuItem<MenuAction>(
              value: MenuAction.logout,
              child: Text('Logout'),
            ),
            PopupMenuItem<MenuAction>(
              value: MenuAction.more,
              child: Text('more'),
            ),
          ];
        });
  }

// AppBar
  AppBar appbar() {
    return AppBar(
      title: const Text(
        'HOME',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        popUpMenu(), //call PopUpMenu
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(), //call App widgit
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
