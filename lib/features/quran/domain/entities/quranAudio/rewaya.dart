import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Rewaya extends Equatable {
  int? id;
  String? name;

  Rewaya({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
