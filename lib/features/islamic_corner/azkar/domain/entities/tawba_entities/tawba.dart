// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'tawba_array.dart';

class Tawba extends Equatable {
  int? id;
  String? category;
  List<TawbaArray>? array;

  Tawba({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
