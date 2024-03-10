// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Month extends Equatable {
  int? number;
  String? en;

  Month({required this.number, required this.en});

  @override
  List<Object?> get props => [number, en];
}
