import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/utils/failure.dart';

abstract class CoreUsecases<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params input);
}

class NoParams {}
