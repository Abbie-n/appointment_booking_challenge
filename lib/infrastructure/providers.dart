import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:appointment_booking_challenge/domain/repositories/i_booking_repository.dart';
import 'package:appointment_booking_challenge/infrastructure/api/api_service.dart';
import 'package:appointment_booking_challenge/infrastructure/config/injection.dart';
import 'package:appointment_booking_challenge/infrastructure/repositories/booking_repository.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/book_slot/book_slot_notifier.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/book_slot/book_slot_state.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/get_slots/get_slots_notifier.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/get_slots/get_slots_state.dart';

final apiServiceProvider = Provider<ApiService>(
  (ref) => getIt<ApiService>(),
  name: 'ApiServiceProvider',
);

final bookingRepositoryProvider = Provider<IBookingRepository>(
  (ref) => BookingRepository(apiService: ref.watch(apiServiceProvider)),
  name: 'BookingRepositoryProvider',
);

final getSlotsNotifierProvider =
    StateNotifierProvider<GetSlotsNotifier, GetSlotsState>(
  (ref) => GetSlotsNotifier(repository: ref.watch(bookingRepositoryProvider)),
  name: 'GetSlotsNotifierProvider',
);

final bookSlotNotifierProvider =
    StateNotifierProvider<BookSlotNotifier, BookSlotState>(
  (ref) => BookSlotNotifier(repository: ref.watch(bookingRepositoryProvider)),
  name: 'BookSlotNotifierProvider',
);
