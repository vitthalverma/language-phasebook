import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/network/network_exceptions.dart';
import 'package:saathi_assignment/core/utils/failure.dart';
import 'package:saathi_assignment/features/translate/data/remote_data/language_remote_data.dart';
import 'package:saathi_assignment/features/translate/data/remote_data/translate_remote_data.dart';
import 'package:saathi_assignment/features/translate/domain/repository/translate_repository.dart';

class TranslateRepositoryImpl implements TranslateRepository {
  final TranslateRemoteData translateRemoteData;
  final LanguageRemoteData languageRemoteData;

  TranslateRepositoryImpl(this.translateRemoteData, this.languageRemoteData);
  @override
  Future<Either<Failure, String>> translateTextToText(
      String sourceCode, String targetCode, String text) async {
    try {
      final translatedText = await translateRemoteData.translateTextToText(
          sourceCode, targetCode, text);
      return right(translatedText);
    } on NtwkExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> translateTextToSpeech(
      String sourceText, String languageCode) async {
    try {
      final speechData =
          await translateRemoteData.translateToSpeech(sourceText, languageCode);
      return right(speechData);
    } on NtwkExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
