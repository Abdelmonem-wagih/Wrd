// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'duea_array.dart';

class Duea extends Equatable {
  int? id;
  String? category;
  List<DueaArray?> array;

  Duea({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
