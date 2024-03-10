import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final bool status;
  final String message;

  const ErrorMessageModel({
    required this.message,
    required this.status,
  });

  factory ErrorMessageModel.fromjson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      message: json["error"],
      status: json[" status"],
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
