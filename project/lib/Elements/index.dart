import 'package:flutter/material.dart';

bouton(name, context, destination) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
    onPressed: () {
      if (destination != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      }
    },
    child: Text(name),
  );
}

alertBox(name, text, context) {
  return IconButton(
    iconSize: 50,
    icon: const Icon(
      Icons.announcement,
      color: Colors.blue,
    ),
    onPressed: () {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(name),
        content: Text(text),
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    },
  );
}
