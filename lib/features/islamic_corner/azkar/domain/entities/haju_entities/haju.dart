// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'haju_array.dart';



class Haju extends Equatable {
  int? id;
  String? category;
  List<HajuArray>? array;

  Haju({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
