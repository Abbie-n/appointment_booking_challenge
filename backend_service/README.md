# Backend Service

Hello! Please follow the steps below to successfully start the server.

## Navigate to Backend Service Package

First, navigate to the `backend_service` directory:

```bash
cd backend_service
Get Packages

Install the necessary Dart packages for the project:

dart pub get

Code Generation
Run the code generation process to create any necessary files:

dart run build_runner build --delete-conflicting-outputs

Build Docker Container
Build the Docker container and bring up the necessary services:

docker-compose up --build

Start Server
After the Docker container is built, start the server with:

dart run lib/server.dart

Run Tests
Finally, run the tests to ensure everything is working correctly:

dart test test/server_test.dart
