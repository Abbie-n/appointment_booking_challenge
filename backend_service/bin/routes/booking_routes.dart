import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exceptions/exceptions.dart';
import '../repositories/booking_repository.dart';
import '../utils/api/api_response.dart';

class BookingRoutes {
  final BookingRepository repository;

  BookingRoutes(this.repository);

  Router get router {
    final router = Router();

    router.get(
      '/slots',
      (Request request) async {
        try {
          final dateParam = request.url.queryParameters['date'];

          final slots = await repository.getAvailableSlots(dateParam);

          return ApiResponse.ok(slots.map((s) => s.toJson()).toList());
        } on RequestException catch (e) {
          return ApiResponse.badRequest(e.message);
        } on BookingException catch (e) {
          return ApiResponse.serverError(e.message);
        }
      },
    );

    router.post(
      '/slots/<slotId>/book',
      (Request request, String slotId) async {
        try {
          final body = await request.readAsString();
          final Map<String, dynamic> data = json.decode(body);

          final slot = await repository.bookSlot(
            int.parse(slotId),
            data['name'],
          );

          return ApiResponse.ok(slot.toJson());
        } on FormatException catch (_) {
          return ApiResponse.badRequest('Invalid request format');
        } on RequestException catch (e) {
          return ApiResponse.validationError(e.message);
        } on NotFoundException catch (e) {
          return ApiResponse.notFound(e.message);
        } on ConflictException catch (e) {
          return ApiResponse.conflict(e.message);
        } on BookingException catch (e) {
          return ApiResponse.serverError(e.message);
        }
      },
    );

    return router;
  }
}
