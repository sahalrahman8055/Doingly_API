  import 'package:flutter/material.dart';

void showErorrMessage(BuildContext context, {required String message,}) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

void showSuccessMessage(BuildContext context, {required String message}) {
  if (context != null && ScaffoldMessenger.of(context).mounted) {
    final snackBar = SnackBar(content: Center(child: Text(message)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


