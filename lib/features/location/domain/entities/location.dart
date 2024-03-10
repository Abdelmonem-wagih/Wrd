import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String? displayName;
  const Location({required this.displayName});

  @override
  List<Object?> get props => [displayName];
}
