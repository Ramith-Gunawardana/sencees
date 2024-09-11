import 'package:flutter/material.dart';

class AppDefaultButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double widthFactor;
  final double height;
  final VoidCallback onPressed;
  final IconData? icon; // Optional icon parameter

  const AppDefaultButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.widthFactor = 0.9,
    this.height = 55,
    this.icon, // Initialize the icon
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white), // Display icon if provided
                  const SizedBox(width: 8), // Spacing between icon and text
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
      ),
    );
  }
}
