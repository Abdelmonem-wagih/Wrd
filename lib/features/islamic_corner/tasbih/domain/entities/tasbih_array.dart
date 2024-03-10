// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TasbihArray extends Equatable {
  int? id;
  String? text;
  String? title;
  int? count;

  TasbihArray({
    required this.id,
    required this.text,
    required this.title,
    required this.count,
  });

  @override
  List<Object?> get props => [id, text, title,count];
}
