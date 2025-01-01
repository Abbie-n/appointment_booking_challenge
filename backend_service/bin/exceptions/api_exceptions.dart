import 'base_exception.dart';

class NotFoundException extends BaseException {
  const NotFoundException(super.message);
}

class ConflictException extends BaseException {
  const ConflictException(super.message);
}
