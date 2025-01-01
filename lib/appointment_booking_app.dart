import 'package:appointment_booking_challenge/presentation/router/router.dart';
import 'package:appointment_booking_challenge/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class AppointmentBookingApp extends StatelessWidget {
  const AppointmentBookingApp({super.key});

  static final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale('en', 'US'),
      textStyle: themeData.textTheme.bodyMedium?.copyWith(
        color: themeData.colorScheme.onPrimary,
      ),
      backgroundColor: themeData.colorScheme.primary,
      borderRadius: BorderRadius.circular(8),
      toastPositions: StyledToastPosition.bottom,
      toastAnimation: StyledToastAnimation.slideFromLeft,
      reverseAnimation: StyledToastAnimation.slideToRightFade,
      curve: Curves.easeIn,
      reverseCurve: Curves.linear,
      duration: const Duration(seconds: 5),
      dismissOtherOnShow: true,
      animDuration: Duration.zero,
      fullWidth: true,
      isHideKeyboard: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Appointment booking Challenge',
        theme: themeData,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
