import 'package:appointment_booking_challenge/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.buttonColor,
    this.textColor,
    required this.onTap,
    this.loading = false,
  });

  final String text;
  final Color? buttonColor;
  final Color? textColor;

  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            color: themeData.colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: themeData.textTheme.bodySmall?.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
