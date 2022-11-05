import 'package:flutter/material.dart';

Future<void> showErrorMessage(String error, BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          buttonPadding: const EdgeInsets.all(0),
          title: const Center(
            child: Text(
              'Error',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Text(
            error,
            textAlign: TextAlign.center,
          ),
          actions: [
            const Divider(
              height: 0,
            ),
            InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              onTap: (() {
                Navigator.of(context).pop();
              }),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Dismiss',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        );
      });
}

// SnackBar widget (Error msg snack and Succes msg snack)
SnackBar message(Color color, String msg, BuildContext context) {
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

Future<void> showLoading(BuildContext context) {
  return showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> sLoading(BuildContext context) {
  return showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const Dialog(
          elevation: 10,
        );
      });
}
