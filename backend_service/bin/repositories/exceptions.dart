class BookingException implements Exception {
  final String message;
  BookingException(this.message);
}

class RequestException implements Exception {
  final String message;
  RequestException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}

class ConflictException implements Exception {
  final String message;
  ConflictException(this.message);
}
