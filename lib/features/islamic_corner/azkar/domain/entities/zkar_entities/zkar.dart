// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'zkar_array.dart';



class Zkar extends Equatable {
 int? id;
  String? category;
  List<ZkarArray>? array;

  Zkar({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
