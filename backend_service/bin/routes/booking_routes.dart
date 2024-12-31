import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../repositories/booking_repository.dart';
import '../repositories/exceptions.dart';

class BookingRoutes {
  final BookingRepository repo;
  BookingRoutes(this.repo);

  Router get router {
    final router = Router();

    router.get(
      '/slots',
      (Request request) async {
        try {
          final dateParam = request.url.queryParameters['date'];

          if (dateParam == null) {
            return Response(
              400,
              body: json.encode({'error': 'Date parameter is required'}),
              headers: {'content-type': 'application/json'},
            );
          }

          final slots = await repo.getAvailableSlots(dateParam);

          return Response.ok(
            json.encode({'data': slots.map((s) => s.toJson()).toList()}),
            headers: {'content-type': 'application/json'},
          );
        } on RequestException catch (e) {
          return Response(
            400,
            body: json.encode({'error': e.message}),
            headers: {'content-type': 'application/json'},
          );
        } on BookingException catch (e) {
          return Response(
            500,
            body: json.encode({'error': e.message}),
            headers: {'content-type': 'application/json'},
          );
        }
      },
    );

    router.post(
      '/slots/<slotId>/book',
      (Request request, String slotId) async {
        try {
          final body = await request.readAsString();
          final Map<String, dynamic> data = json.decode(body);

          final slot = await repo.bookSlot(
            int.parse(slotId),
            data['name'],
          );

          return Response.ok(
            json.encode({'data': slot.toJson()}),
            headers: {'content-type': 'application/json'},
          );
        } on FormatException catch (_) {
          return Response(
            400,
            body: json.encode({'error': 'Invalid request format'}),
            headers: {'content-type': 'application/json'},
          );
        } on RequestException catch (e) {
          return Response(
            400,
            body: json.encode({'error': e.message}),
            headers: {'content-type': 'application/json'},
          );
        } on NotFoundException catch (e) {
          return Response(
            404,
            body: json.encode({'error': e.message}),
            headers: {'content-type': 'application/json'},
          );
        } on ConflictException catch (e) {
          return Response(
            409,
            body: json.encode({'error': e.message}),
            headers: {'content-type': 'application/json'},
          );
        } on BookingException catch (e) {
          return Response(
            500,
            body: json.encode({'error': e.message}),
            headers: {'content-type': 'application/json'},
          );
        }
      },
    );

    return router;
  }
}
