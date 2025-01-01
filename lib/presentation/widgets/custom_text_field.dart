import 'package:appointment_booking_challenge/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final outlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
);

class CustomTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    this.onChanged,
    required this.controller,
    this.inputFormatters,
    this.hintText,
    this.onTap,
    this.readOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autocorrect: false,
      style: themeData.textTheme.bodyMedium,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: themeData.textTheme.bodyMedium?.copyWith(
          color: themeData.colorScheme.primary.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        filled: false,
        fillColor: themeData.colorScheme.surface,
        border: outlineBorder,
        focusedBorder: outlineBorder,
        enabledBorder: outlineBorder,
        disabledBorder: outlineBorder,
      ),
      inputFormatters: inputFormatters,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
