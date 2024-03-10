// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class DueaArray extends Equatable {
  int? id;
  String? text;
  String? repeat;
  int? count;

  DueaArray({
    required this.id,
    required this.text,
    required this.count,
    required this.repeat
  });

  @override
  List<Object?> get props => [id, text, count , repeat];
}
