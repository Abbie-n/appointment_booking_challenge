import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:appointment_booking_challenge/domain/models/slot.dart';
import 'package:appointment_booking_challenge/domain/repositories/i_booking_repository.dart';
import 'package:appointment_booking_challenge/infrastructure/api/api_service.dart';
import 'package:appointment_booking_challenge/infrastructure/api/endpoints.dart';

@Injectable(as: IBookingRepository)
class BookingRepository implements IBookingRepository {
  final ApiService apiService;

  BookingRepository({required this.apiService});

  @override
  Future<List<Slot>> getSlots(DateTime date) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      final response = await apiService.get(
        Endpoint.getSlots,
        params: {'date': formattedDate},
      );

      final data = response['data'] as List<dynamic>? ?? [];

      List<Slot> slots = [];
      data.map((d) => slots.add(Slot.fromJson(d))).toList();

      return slots;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> bookSlot({required int slotId, required String name}) async {
    try {
      final response = await apiService.post(
        Endpoint.bookSlot(slotId),
        body: {'name': name},
      );

      final slot = Slot.fromJson(response['data']);

      return slot.id != null;
    } catch (e) {
      throw Exception();
    }
  }
}
