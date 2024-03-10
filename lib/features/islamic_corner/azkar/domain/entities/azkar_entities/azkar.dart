// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'azkar_array.dart';

class Azkar extends Equatable {
  int? id;
  String? category;
  List<AzkarArray>? array;

  Azkar({
    required this.id,
    required this.category,
    required this.array,
  });

  @override
  List<Object?> get props => [id, category, array];
}
