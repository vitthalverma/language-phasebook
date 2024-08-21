import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/network/network_exceptions.dart';
import 'package:saathi_assignment/core/utils/failure.dart';
import 'package:saathi_assignment/features/translate/data/remote_data/language_remote_data.dart';
import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';
import 'package:saathi_assignment/features/translate/domain/repository/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageRemoteData languageRemoteData;

  LanguageRepositoryImpl(this.languageRemoteData);
  @override
  Future<Either<Failure, List<LanguageEntity>>> fetchAllLanguages() async {
    try {
      final languages = await languageRemoteData.fetchAllLanguages();
      return right(languages);
    } on NtwkExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
