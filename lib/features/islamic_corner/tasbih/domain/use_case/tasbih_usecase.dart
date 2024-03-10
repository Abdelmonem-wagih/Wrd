import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';

import '../../../../../core/usecases/usecase.dart';
import '../entities/tasbih.dart';
import '../repository/base_tasbih_repository.dart';

class TasbihUseCase extends UseCase<List<Tasbih>, NoParams> {
  final BaseTasbihRepository baseTasbihRepository;

  TasbihUseCase({required this.baseTasbihRepository});

  @override
  Future<Either<Failure, List<Tasbih>>> call(NoParams params) async {
    return await baseTasbihRepository.getAllTasbih();
  }
}
