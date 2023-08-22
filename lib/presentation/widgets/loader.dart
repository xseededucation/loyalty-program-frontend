import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 20.0),
                  Text("Loading..."),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
