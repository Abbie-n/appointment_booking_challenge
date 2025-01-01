import 'package:appointment_booking_challenge/domain/models/slot.dart';

abstract interface class IBookingRepository {
  Future<List<Slot>> getSlots(DateTime date);

  Future<bool> bookSlot({required int slotId, required String name});
}
