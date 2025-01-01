import 'package:appointment_booking_challenge/appointment_booking_app.dart';
import 'package:appointment_booking_challenge/infrastructure/config/injection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await serviceLocator();

  runApp(
    const ProviderScope(
      child: AppointmentBookingApp(),
    ),
  );
}
