import 'package:appointment_booking_challenge/theme.dart';
import 'package:flutter/material.dart';

class ConfirmationItem extends StatelessWidget {
  const ConfirmationItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        '$title: $value',
        style: themeData.textTheme.bodyMedium,
      ),
    );
  }
}
