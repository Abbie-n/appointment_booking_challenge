import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:appointment_booking_challenge/domain/repositories/i_booking_repository.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/book_slot/book_slot_state.dart';

@lazySingleton
class BookSlotNotifier extends StateNotifier<BookSlotState> {
  final IBookingRepository repository;

  BookSlotNotifier({required this.repository})
      : super(const BookSlotState.initial());

  Future<void> bookSlot({required int slotId, required String name}) async {
    state = const BookSlotState.loading();
    try {
      final isBooked = await repository.bookSlot(name: name, slotId: slotId);

      state = isBooked
          ? const BookSlotState.success()
          : const BookSlotState.error();
    } catch (e) {
      state = const BookSlotState.error();
    }
  }
}
