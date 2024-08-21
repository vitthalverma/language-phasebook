import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/utils/failure.dart';
import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';

abstract interface class LanguageRepository {
  Future<Either<Failure, List<LanguageEntity>>> fetchAllLanguages();
}
