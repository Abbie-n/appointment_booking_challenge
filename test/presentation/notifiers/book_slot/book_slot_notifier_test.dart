import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:appointment_booking_challenge/domain/repositories/i_booking_repository.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/book_slot/book_slot_notifier.dart';
import 'package:appointment_booking_challenge/presentation/notifiers/book_slot/book_slot_state.dart';

@GenerateNiceMocks([MockSpec<IBookingRepository>()])
import 'book_slot_notifier_test.mocks.dart';

const slotId = 1;
const name = 'John Doe';
void main() {
  group('BookSlotNotifier Tests', () {
    late MockIBookingRepository mockRepository;
    late BookSlotNotifier notifier;

    setUp(() {
      mockRepository = MockIBookingRepository();
      notifier = BookSlotNotifier(repository: mockRepository);
    });

    test('bookSlot success should update state correctly', () async {
      // Arrange
      final states = <BookSlotState>[];

      notifier.addListener((state) {
        states.add(state);
      });

      when(mockRepository.bookSlot(
        slotId: slotId,
        name: name,
      )).thenAnswer((_) async => true);

      // Act
      await notifier.bookSlot(slotId: slotId, name: name);

      // Assert
      expect(states, [
        const BookSlotState.initial(),
        const BookSlotState.loading(),
        const BookSlotState.success(),
      ]);
    });

    test('bookSlot failure should update state to error', () async {
      // Arrange
      final states = <BookSlotState>[];

      notifier.addListener((state) {
        states.add(state);
      });

      when(mockRepository.bookSlot(
        slotId: slotId,
        name: name,
      )).thenAnswer((_) => Future.value(false));

      // Act
      await notifier.bookSlot(slotId: slotId, name: name);

      // Assert
      expect(states, [
        const BookSlotState.initial(),
        const BookSlotState.loading(),
        const BookSlotState.error(),
      ]);
    });

    test('bookSlot exception should update state to error', () async {
      // Arrange
      final states = <BookSlotState>[];

      notifier.addListener((state) {
        states.add(state);
      });

      when(mockRepository.bookSlot(
        slotId: slotId,
        name: name,
      )).thenThrow(Exception());

      // Act
      await notifier.bookSlot(slotId: slotId, name: name);

      // Assert
      expect(states, [
        const BookSlotState.initial(),
        const BookSlotState.loading(),
        const BookSlotState.error(),
      ]);
    });
  });
}
