import 'package:appointment_booking_challenge/presentation/helper.dart';
import 'package:appointment_booking_challenge/presentation/widgets/custom_date_picker.dart';
import 'package:appointment_booking_challenge/presentation/widgets/slot_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:appointment_booking_challenge/infrastructure/providers.dart';
import 'package:appointment_booking_challenge/theme.dart';

@RoutePage()
class BookingPage extends HookConsumerWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(getSlotsNotifierProvider.notifier);
    final state = ref.watch(getSlotsNotifierProvider);

    final selectedDate = useState(DateTime.now());
    final dateController = useTextEditingController();

    void getSlotsbyDate(DateTime date) {
      dateController.text = Helper.formatTextFieldDate(date);

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await notifier.getSlots(date);
      });
    }

    useEffect(() {
      getSlotsbyDate(selectedDate.value);

      return null;
    }, []);

    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: false,
        title: Text(
          'Booking',
          style: themeData.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDatePicker(
              controller: dateController,
              onDateChange: (value) {
                selectedDate.value = value;

                getSlotsbyDate(selectedDate.value);
              },
              selectedDate: selectedDate.value,
            ),
            const SizedBox(height: 32),
            Text(
              'Pick a slot',
              style: themeData.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            state.maybeWhen(
              finished: (slots) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [...slots.map((slot) => SlotWidget(slot: slot))],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              orElse: () => const Text('No Slots available at this time.'),
            ),
          ],
        ),
      ),
    );
  }
}
