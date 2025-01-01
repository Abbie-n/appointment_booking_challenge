import 'package:appointment_booking_challenge/domain/models/slot.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_slots_state.freezed.dart';

@freezed
class GetSlotsState with _$GetSlotsState {
  const factory GetSlotsState.initial() = _Initial;

  const factory GetSlotsState.loading() = _Loading;

  const factory GetSlotsState.finished(List<Slot> slots) = _Finished;

  const factory GetSlotsState.empty() = _Empty;

  const factory GetSlotsState.error() = _Error;
}
