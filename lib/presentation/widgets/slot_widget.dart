import 'package:appointment_booking_challenge/domain/models/slot.dart';
import 'package:appointment_booking_challenge/presentation/helper.dart';
import 'package:appointment_booking_challenge/presentation/pages/components/booking_confirmation_dialog.dart';
import 'package:appointment_booking_challenge/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SlotWidget extends HookWidget {
  const SlotWidget({
    super.key,
    required this.slot,
  });

  final Slot slot;

  @override
  Widget build(BuildContext context) {
    void showConfirmationDialog() async {
      await showAdaptiveDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BookingConfirmationDialog(slot: slot);
        },
      );
    }

    return GestureDetector(
      onTap: slot.booked == false ? showConfirmationDialog : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: slot.booked == true
              ? themeData.colorScheme.primary.withOpacity(0.3)
              : null,
          border: Border.all(
            color: slot.booked == true
                ? themeData.colorScheme.primary.withOpacity(0.5)
                : themeData.colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          Helper.formatDateStringToTime(slot.startDate ?? ''),
          style: themeData.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
