import 'package:flutter/material.dart';

class LoadingDialog {
  static final GlobalKey<State> _loadingKey = GlobalKey<State>();

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: _loadingKey,
            backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog() {
    Navigator.of(_loadingKey.currentContext!).pop();
  }
}
