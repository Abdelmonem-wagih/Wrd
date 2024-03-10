import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Moshaf extends Equatable {
  int? id;
  int? surahTotal;
  String? name;
  String? server;
  String? surahList;

  Moshaf(
      {required this.id,
      required this.surahTotal,
      required this.name,
      required this.server,
      required this.surahList});

  @override
  List<Object?> get props => [id, name, server, surahList, surahTotal];
}
