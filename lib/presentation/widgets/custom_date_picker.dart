import 'package:appointment_booking_challenge/presentation/widgets/custom_text_field.dart';
import 'package:appointment_booking_challenge/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDatePicker extends HookWidget {
  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.onDateChange,
    required this.selectedDate,
  });

  final ValueChanged<DateTime> onDateChange;

  final DateTime selectedDate;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Date',
          style: themeData.textTheme.headlineSmall,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomTextField(
            hintText: 'Select date',
            controller: controller,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2024),
                lastDate: DateTime(2044),
              );

              if (pickedDate != null) {
                onDateChange(pickedDate.toLocal());
              }
            },
          ),
        )
      ],
    );
  }
}
