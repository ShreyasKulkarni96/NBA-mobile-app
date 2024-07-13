import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: kIsWeb ? ToastGravity.CENTER : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      // webShowClose: true,
      webPosition: "center",
      fontSize: 14.0);
}



Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

checkInternet(context) async {
  if (!kIsWeb) {
    if (await hasNetwork() == false) {
      noInternetConnectionPrompt(context);
      //showConnSnackBar(context, "No Internet Connection");
    }
  }
}

noInternetConnectionPrompt(BuildContext context) {
  // set up the button
  Widget confirmButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "No Internet Connection",
      style: TextStyle(fontSize: 16),
    ),
    content: Text(
      "You are offline please check your internet connection?",
      style: TextStyle(fontSize: 16),
    ),
    actions: [confirmButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

serverProblemDialog(BuildContext context) {
  // set up the button
  Widget confirmButton = TextButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Server Error",
      style: TextStyle(fontSize: 16),
    ),
    content: Text(
      "We are having some issues. Please check back later",
      style: TextStyle(fontSize: 16),
    ),
    actions: [confirmButton],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}






