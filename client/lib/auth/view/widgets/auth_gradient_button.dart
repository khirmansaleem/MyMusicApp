import 'package:flutter/material.dart';

import '../../../core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text; // 👈 declare a text variable

  const AuthGradientButton({
    super.key,
    required this.text,
    required this.onTap, // 👈 make it required in constructor
  });

  @override
  Widget build(BuildContext context) {
    // in order to make a gradient button
    // wrapped the elevated button with container and
    // apply gradient property to the container
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: Pallete.transparentColor,
            shadowColor: Pallete.transparentColor // 👈 button size
            ),
        child: Text(
          text, // 👈 passed-in text
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
