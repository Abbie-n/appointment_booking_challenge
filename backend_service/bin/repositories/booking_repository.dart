import 'package:postgres/postgres.dart';

import '../models/slot.dart';
import 'exceptions.dart';

class BookingRepository {
  final Connection connection;

  BookingRepository(this.connection);

  Future<List<Slot>> getAvailableSlots(String date) async {
    try {
      if (date.trim().isEmpty) {
        throw RequestException('Date parameter is required.');
      }

      final result = await connection.execute(
        Sql.named('''
          SELECT id, start_date, booked, booked_by 
          FROM slots 
          WHERE DATE(start_date) = @date
          ORDER BY start_date ASC
        '''),
        parameters: {'date': date},
      );

      return result
          .map(
            (row) => Slot.fromJson(
              {
                'id': row[0],
                'start_date': convertDateTimeToString(row[1]),
                'booked': row[2],
                'booked_by': row[3],
              },
            ),
          )
          .toList();
    } catch (e) {
      print('Error: ${e.toString()}');

      if (e is RequestException) rethrow;

      throw BookingException('An error occurred while fetching slots.');
    }
  }

  Future<Slot> bookSlot(int slotId, String name) async {
    if (name.trim().isEmpty) {
      throw RequestException('Name is required in request body.');
    }

    if (slotId <= 0) {
      throw RequestException('Invalid slot ID.');
    }

    try {
      return await connection.runTx(
        (ctx) async {
          final checkResult = await ctx.execute(
            Sql.named('SELECT booked FROM slots WHERE id = @id FOR UPDATE'),
            parameters: {'id': slotId},
          );

          if (checkResult.isEmpty) {
            throw NotFoundException('Slot not found');
          }

          if (checkResult[0][0] == true) {
            throw ConflictException('Slot already booked');
          }

          final result = await ctx.execute(
            Sql.named('''
            UPDATE slots 
            SET booked = true, booked_by = @name 
            WHERE id = @id 
            RETURNING id, start_date, booked, booked_by
          '''),
            parameters: {'id': slotId, 'name': name.trim()},
          );

          return Slot.fromJson({
            'id': result[0][0],
            'start_date': convertDateTimeToString(result[0][1]),
            'booked': result[0][2],
          });
        },
      );
    } catch (e) {
      if (e is RequestException) rethrow;

      if (e is NotFoundException) rethrow;

      if (e is ConflictException) rethrow;

      print('Error: ${e.toString()}');

      throw BookingException('An error occurred while booking.');
    }
  }

  String convertDateTimeToString(dynamic value) {
    if (value is DateTime) {
      return value.toUtc().toIso8601String();
    }

    print('Error: invalid date format - ${value.runtimeType}');

    throw BookingException('Invalid date format.');
  }
}
