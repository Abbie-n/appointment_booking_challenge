import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:intl/intl.dart';
import 'package:appointment_booking_challenge/domain/models/slot.dart';
import 'package:appointment_booking_challenge/infrastructure/api/api_service.dart';
import 'package:appointment_booking_challenge/infrastructure/api/endpoints.dart';
import 'package:appointment_booking_challenge/infrastructure/repositories/booking_repository.dart';

@GenerateNiceMocks([MockSpec<ApiService>()])
import 'booking_repository_test.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late BookingRepository repository;

  setUp(() {
    mockApiService = MockApiService();
    repository = BookingRepository(apiService: mockApiService);
  });

  group('BookingRepository - getSlots', () {
    final testDate = DateTime(2024, 1, 1);
    final formattedDate = DateFormat('yyyy-MM-dd').format(testDate);

    test('should return list of slots when API call is successful', () async {
      // Arrange
      final mockResponse = {
        'data': [
          {'id': 1, 'startDate': '2024-01-01T10:00:00', 'booked': false},
          {'id': 2, 'startDate': '2024-01-01T11:00:00', 'booked': true}
        ]
      };

      when(mockApiService.get(
        Endpoint.getSlots,
        params: {'date': formattedDate},
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getSlots(testDate);

      // Assert
      expect(result, isA<List<Slot>>());
      expect(result.length, 2);
      expect(result.first.id, 1);
      expect(result.first.booked, false);
      expect(result.last.id, 2);
      expect(result.last.booked, true);
    });

    test('should return empty list when API returns no data', () async {
      // Arrange
      when(mockApiService.get(
        Endpoint.getSlots,
        params: {'date': formattedDate},
      )).thenAnswer((_) async => {'data': []});

      // Act
      final result = await repository.getSlots(testDate);

      // Assert
      expect(result, isEmpty);
    });

    test('should throw Exception when API call fails', () async {
      // Arrange
      when(mockApiService.get(
        Endpoint.getSlots,
        params: {'date': formattedDate},
      )).thenThrow(Exception());

      // Act & Assert
      expect(() => repository.getSlots(testDate), throwsException);
    });
  });

  group('BookingRepository - bookSlot', () {
    const testSlotId = 1;
    const testName = 'John Doe';

    test('should return true when booking is successful', () async {
      // Arrange
      final mockResponse = {
        'data': {
          'id': testSlotId,
          'startDate': '2024-01-01T10:00:00',
          'endDate': '2024-01-01T11:00:00',
          'booked': true
        }
      };

      when(mockApiService.post(
        Endpoint.bookSlot(testSlotId),
        body: {'name': testName},
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.bookSlot(
        slotId: testSlotId,
        name: testName,
      );

      // Assert
      expect(result, true);
    });

    test('should return false when booking response has no ID', () async {
      // Arrange
      final mockResponse = {
        'data': {
          'startDate': '2024-01-01T10:00:00',
          'endDate': '2024-01-01T11:00:00',
          'booked': true
        }
      };

      when(mockApiService.post(
        Endpoint.bookSlot(testSlotId),
        body: {'name': testName},
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.bookSlot(
        slotId: testSlotId,
        name: testName,
      );

      // Assert
      expect(result, false);
    });

    test('should throw Exception when booking API call fails', () async {
      // Arrange
      when(mockApiService.post(
        Endpoint.bookSlot(testSlotId),
        body: {'name': testName},
      )).thenThrow(Exception());

      // Act & Assert
      expect(
        () => repository.bookSlot(slotId: testSlotId, name: testName),
        throwsException,
      );
    });
  });
}
