// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'tasbih_array.dart';

class Tasbih extends Equatable {
  int? id;
  String? category;
  List<TasbihArray?> array;

  Tasbih({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
