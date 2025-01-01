import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:appointment_booking_challenge/domain/models/slot.dart';
import 'package:appointment_booking_challenge/domain/repositories/i_booking_repository.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/get_slots/get_slots_notifier.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/get_slots/get_slots_state.dart';

import 'get_slots_notifier_test.mocks.dart';

@GenerateMocks([IBookingRepository])
final testDate = DateTime(2024, 1, 1);

final mockSlots = [
  Slot(
    id: 1,
    startDate: '2024-01-01T10:00:00',
    booked: false,
  ),
];

void main() {
  group('GetSlotsNotifier Tests', () {
    late MockIBookingRepository mockRepository;
    late GetSlotsNotifier notifier;

    setUp(() {
      mockRepository = MockIBookingRepository();
      notifier = GetSlotsNotifier(repository: mockRepository);
    });

    test('getSlots should return slots when available', () async {
      // Arrange
      final states = <GetSlotsState>[];

      notifier.addListener((state) {
        states.add(state);
      });

      when(mockRepository.getSlots(testDate))
          .thenAnswer((_) => Future.value([...mockSlots]));

      // Act
      await notifier.getSlots(testDate);

      // Assert
      expect(states, [
        const GetSlotsState.initial(),
        const GetSlotsState.loading(),
        GetSlotsState.finished(mockSlots),
      ]);
    });

    test('getSlots should return empty state when no slots available',
        () async {
      final states = <GetSlotsState>[];

      notifier.addListener((state) {
        states.add(state);
      });
      // Arrange
      when(mockRepository.getSlots(testDate))
          .thenAnswer((_) => Future.value([]));

      // Act
      await notifier.getSlots(testDate);

      // Assert
      expect(states, [
        const GetSlotsState.initial(),
        const GetSlotsState.loading(),
        const GetSlotsState.empty(),
      ]);
    });

    test('getSlots should return error state on exception', () async {
      final states = <GetSlotsState>[];

      notifier.addListener((state) {
        states.add(state);
      });

      // Arrange
      when(mockRepository.getSlots(testDate)).thenThrow(Exception());

      // Act
      await notifier.getSlots(testDate);

      // Assert
      expect(states, [
        const GetSlotsState.initial(),
        const GetSlotsState.loading(),
        const GetSlotsState.error()
      ]);
    });
  });
}
