import 'dart:collection';

import 'package:mockito/mockito.dart';
import 'package:postgres/postgres.dart';

class MockResultRow extends Fake implements ResultRow {
  final List<Object?> _values;

  MockResultRow(this._values);

  @override
  Object? operator [](int index) => _values[index];
}

class MockResult extends Fake implements Result {
  final List<List<Object?>> rows;

  MockResult(this.rows);

  @override
  Iterator<ResultRow> get iterator =>
      rows.map((r) => MockResultRow(r)).iterator;

  @override
  UnmodifiableListView<T> map<T>(T Function(ResultRow) f) {
    return UnmodifiableListView(rows.map((r) => f(MockResultRow(r))).toList());
  }
}
