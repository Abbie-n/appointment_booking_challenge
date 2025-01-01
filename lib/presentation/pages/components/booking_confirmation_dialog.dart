import 'package:appointment_booking_challenge/domain/models/slot.dart';
import 'package:appointment_booking_challenge/infrastructure/providers.dart';
import 'package:appointment_booking_challenge/presentation/helper.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/book_slot/book_slot_state.dart';
import 'package:appointment_booking_challenge/presentation/pages/components/widgets/confirmation_item.dart';
import 'package:appointment_booking_challenge/presentation/widgets/custom_button.dart';
import 'package:appointment_booking_challenge/presentation/widgets/custom_text_field.dart';
import 'package:appointment_booking_challenge/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingConfirmationDialog extends HookConsumerWidget {
  const BookingConfirmationDialog({
    super.key,
    required this.slot,
  });

  final Slot slot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(bookSlotNotifierProvider.notifier);
    final state = ref.watch(bookSlotNotifierProvider);

    final getSlotsNotifier = ref.watch(getSlotsNotifierProvider.notifier);

    final nameController = useTextEditingController();

    final enableButton = useState(false);

    void updateListener() =>
        enableButton.value = nameController.text.trim().isNotEmpty;

    ref.listen<BookSlotState>(
      bookSlotNotifierProvider,
      (previous, current) {
        current.maybeWhen(
          success: () {
            showToast('Slot successfully booked!');

            getSlotsNotifier.getSlots(
              Helper.formatDateStringToDate(slot.startDate ?? ''),
            );

            context.router.maybePop();
          },
          error: () {
            showToast(
              'Failed to book slot!',
              backgroundColor: themeData.colorScheme.error,
            );

            context.router.maybePop();
          },
          orElse: () => null,
        );
      },
    );

    void handleBook() {
      if (slot.id != null && enableButton.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await notifier.bookSlot(
            name: nameController.text,
            slotId: slot.id!,
          );
        });
      }
    }

    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: themeData.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Book this slot?',
                style: themeData.textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: themeData.colorScheme.primary,
              thickness: 1,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Text(
                  'Your name:',
                  style: themeData.textTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Enter name',
                    controller: nameController,
                    readOnly: false,
                    onChanged: (_) => updateListener(),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            ConfirmationItem(
              title: 'Date',
              value: Helper.formatDateString(slot.startDate ?? ''),
            ),
            ConfirmationItem(
              title: 'Time',
              value: Helper.formatDateStringToTime(slot.startDate ?? ''),
            ),
            const ConfirmationItem(
              title: 'Duration',
              value: '60 minutes',
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onTap: () => context.router.maybePop(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: 'Book',
                    loading: state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    ),
                    buttonColor: !enableButton.value
                        ? themeData.colorScheme.primary.withOpacity(0.3)
                        : themeData.colorScheme.secondary,
                    textColor: themeData.colorScheme.primary,
                    onTap: handleBook,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
