// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'says_array.dart';

class Says extends Equatable {
  int? id;
  String? category;
  List<SaysArray>? array;

  Says({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
