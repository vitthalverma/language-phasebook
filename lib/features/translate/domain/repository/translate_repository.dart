import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/utils/failure.dart';

abstract interface class TranslateRepository {
  Future<Either<Failure, String>> translateTextToText(
      String sourceCode, String targetCode, String text);
  Future<Either<Failure, String>> translateTextToSpeech(
      String sourceText, String languageCode);
}
