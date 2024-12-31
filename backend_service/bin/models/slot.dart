import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class Slot {
  final int id;
  final String startDate;
  final bool booked;
  final String? bookedBy;

  Slot({
    required this.id,
    required this.startDate,
    required this.booked,
    this.bookedBy,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

  Map<String, dynamic> toJson() => _$SlotToJson(this);
}
