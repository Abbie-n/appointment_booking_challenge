import 'package:appointment_booking_challenge/presentation/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(path: '/', page: BookingRoute.page)];
}
