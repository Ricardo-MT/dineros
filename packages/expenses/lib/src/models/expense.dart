import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// {@template expense}
/// A single `expense`.
///
/// Contains a [id], [date], [name] and [price].
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Expense]s are immutable and can be copied using [copyWith].
/// {@endtemplate}
@immutable
@JsonSerializable()
class Expense extends Equatable {
  /// {@macro expense}
  Expense({
    required this.date,
    required this.name,
    required this.price,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `expense`.
  ///
  /// Cannot be empty.
  final String id;

  /// The date this `expense` was created.
  final DateTime date;

  /// The name of this `expense`.
  final String name;

  /// The price of this `expense`.
  final double price;

  /// Returns a copy of this `expense` with the given values updated.
  ///
  /// {@macro expense}
  Expense copyWith({
    String? id,
    DateTime? date,
    String? name,
    double? price,
  }) {
    return Expense(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        name,
        price,
      ];
}
