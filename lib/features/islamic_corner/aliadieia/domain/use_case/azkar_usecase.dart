import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../core/usecases/usecase.dart';
import '../entities/duea.dart';
import '../repository/base_duea_repository.dart';

class DueaUseCase extends UseCase<List<Duea>, NoParams> {
  final BaseDueaRepository baseDueaRepository;

  DueaUseCase({required this.baseDueaRepository});

  @override
  Future<Either<Failure, List<Duea>>> call(NoParams params) async {
    return await baseDueaRepository.getAllAliadieia();
  }
}
