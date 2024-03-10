// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'tashahhud_array.dart';


class Tashahhud extends Equatable {
  int? id;
  String? category;
  List<TashahhudArray?> array;

  Tashahhud({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
