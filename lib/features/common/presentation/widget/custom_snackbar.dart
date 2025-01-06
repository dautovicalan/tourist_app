import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0, // Remove elevation
    content: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(250, 253, 255, 1), // Inner color
        border: Border.all(
          color: const Color.fromRGBO(157, 44, 86, 1), // Border color
          width: 3, // Border thickness
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info, // Info icon
            color: const Color.fromRGBO(157, 44, 86, 1), // Icon color
          ),
          const SizedBox(width: 10), // Spacing between icon and text
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black, // Text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
    behavior: SnackBarBehavior.floating, // Float the snackbar
    margin: const EdgeInsets.all(16), // Margin around the snackbar
    duration: const Duration(seconds: 3), // Duration the snackbar is visible
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}