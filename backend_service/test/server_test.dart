import '../bin/repositories/booking_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';
import '../bin/models/slot.dart';
import '../bin/repositories/exceptions.dart';

import 'mock_result.dart';
import 'server_test.mocks.dart';

@GenerateMocks([Connection, BookingRepository])
void main() {
  late MockConnection mockConnection;
  MockResult result = MockResult(
    [
      [1, DateTime.parse('2024-05-01T09:00:00Z'), false, null],
      [2, DateTime.parse('2024-05-01T10:00:00Z'), false, null],
    ],
  );

  late BookingRepository repository;

  setUp(() {
    mockConnection = MockConnection();
    repository = BookingRepository(mockConnection);
  });

  group('getAvailableSlots', () {
    test('returns list of slots when valid date provided', () async {
      when(mockConnection.execute(any, parameters: anyNamed('parameters')))
          .thenAnswer((_) async => result);

      final slots = await repository.getAvailableSlots('2024-05-01');

      expect(slots.length, 2);
      expect(slots[0].id, 1);
      expect(slots[0].startDate, '2024-05-01T09:00:00.000Z');
      expect(slots[0].booked, false);
    });

    test('throws RequestException when empty date provided', () {
      expect(
        () => repository.getAvailableSlots(''),
        throwsA(isA<RequestException>()),
      );
    });

    test('throws BookingException on database error', () {
      when(mockConnection.execute(any, parameters: anyNamed('parameters')))
          .thenThrow(Exception('DB Error'));

      expect(
        () => repository.getAvailableSlots('2024-05-01'),
        throwsA(isA<BookingException>()),
      );
    });
  });

  group('bookSlot', () {
    test('successfully books available slot', () async {
      when(mockConnection.runTx(any)).thenAnswer((_) async {
        return Slot.fromJson({
          'id': 1,
          'start_date': '2024-05-01T09:00:00.000Z',
          'booked': true,
        });
      });

      final slot = await repository.bookSlot(1, 'John Doe');

      expect(slot.id, 1);
      expect(slot.booked, true);
    });

    test('throws RequestException when empty name provided', () {
      expect(
        () => repository.bookSlot(1, '  '),
        throwsA(isA<RequestException>()),
      );
    });

    test('throws RequestException when invalid slot ID provided', () {
      expect(
        () => repository.bookSlot(0, 'John Doe'),
        throwsA(isA<RequestException>()),
      );
    });

    test('throws NotFoundException when slot does not exist', () {
      when(mockConnection.runTx(any))
          .thenAnswer((_) async => throw NotFoundException('Slot not found'));

      expect(
        () => repository.bookSlot(999, 'John Doe'),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('throws ConflictException when slot already booked', () {
      when(mockConnection.runTx(any)).thenAnswer(
          (_) async => throw ConflictException('Slot already booked'));

      expect(
        () => repository.bookSlot(1, 'John Doe'),
        throwsA(isA<ConflictException>()),
      );
    });
  });
}
