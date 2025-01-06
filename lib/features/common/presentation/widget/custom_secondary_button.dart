import 'package:flutter/material.dart';
import 'package:tourist_app/core/style/style_extensions.dart';

class CustomSecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CustomSecondaryButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 15, 14, 14),
          backgroundColor: context.colorGradientBegin,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(               
                color: Color.fromRGBO(209, 116, 56, 1),
                width: 3.0,
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 55.0),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
