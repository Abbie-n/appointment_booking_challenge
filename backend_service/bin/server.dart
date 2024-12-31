import 'dart:io';
import 'repositories/booking_repository.dart';
import 'routes/booking_routes.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Future<void> main() async {
  Connection? connection;
  HttpServer? server;

  try {
    connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        port: 5432,
        // these values should be in a .env file,
        // but to allow for external testing, it has been hardcoded.
        database: 'coding-challenge',
        username: 'postgres',
        password: 'mypassword123!',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    final repository = BookingRepository(connection);
    final routes = BookingRoutes(repository);

    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addMiddleware(handleErrors())
        .addHandler(routes.router.call);

    server = await io.serve(handler, 'localhost', 8080);

    print('Server running at http://${server.address.host}:${server.port}');

    ProcessSignal.sigint.watch().listen((_) async {
      await shutdown(server, connection);
    });
  } catch (e) {
    print('Startup error: $e');
    await shutdown(server, connection);
    exit(1);
  }
}

Future<void> shutdown(HttpServer? server, Connection? connection) async {
  print('Shutting down...');
  await server?.close(force: false);
  await connection?.close();
  exit(0);
}

Middleware handleErrors() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } catch (e) {
        return Response.internalServerError(
          body: "{'error': 'Internal server error'}",
          headers: {'content-type': 'application/json'},
        );
      }
    };
  };
}
