import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_slot_state.freezed.dart';

@freezed
class BookSlotState with _$BookSlotState {
  const factory BookSlotState.initial() = _Initial;

  const factory BookSlotState.loading() = _Loading;

  const factory BookSlotState.success() = _Success;

  const factory BookSlotState.error() = _Error;
}
