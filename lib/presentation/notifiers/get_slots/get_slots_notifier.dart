import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:appointment_booking_challenge/domain/repositories/i_booking_repository.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/get_slots/get_slots_state.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSlotsNotifier extends StateNotifier<GetSlotsState> {
  final IBookingRepository repository;

  GetSlotsNotifier({required this.repository})
      : super(const GetSlotsState.initial());

  Future<void> getSlots(DateTime date) async {
    state = const GetSlotsState.loading();

    try {
      final result = await repository.getSlots(date);

      state = result.isNotEmpty
          ? GetSlotsState.finished(result)
          : const GetSlotsState.empty();
    } catch (e) {
      state = const GetSlotsState.error();
    }
  }
}
