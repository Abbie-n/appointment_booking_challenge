class Endpoint {
  static const baseUrl = 'http://localhost:8080';

  static const getSlots = '/slots';

  static String bookSlot(int id) => '/slots/$id/book';
}
