import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/usecase/core_usecase.dart';
import 'package:saathi_assignment/core/utils/failure.dart';
import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';
import 'package:saathi_assignment/features/translate/domain/repository/language_repository.dart';

class FetchAllLanguagesUsecase
    implements CoreUsecases<List<LanguageEntity>, NoParams> {
  final LanguageRepository languageRepository;

  FetchAllLanguagesUsecase(this.languageRepository);
  @override
  Future<Either<Failure, List<LanguageEntity>>> call(NoParams input) async {
    return await languageRepository.fetchAllLanguages();
  }
}
