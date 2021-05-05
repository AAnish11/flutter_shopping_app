import 'package:flutter/material.dart';

class DialogAlertsHelper {
  static void showAlert(BuildContext context, String msg, Function cb,
      {String title = 'Confirm'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                cb(true);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                cb(false);
              },
            )
          ],
        );
      },
    );
  }

  static void showSuccessMsg(BuildContext context, String msg, Function cb) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                cb();
              },
            ),
          ],
        );
      },
    );
  }

  static void showErrorMsg(BuildContext context, String msg, Function cb) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
                cb();
              },
            ),
          ],
        );
      },
    );
  }

  static void showSpinner(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static showSnackBarMessage(BuildContext context, String msg, {int second = 1}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      elevation: 16,
      duration: Duration(seconds: second),
    ));
  }
  
}
