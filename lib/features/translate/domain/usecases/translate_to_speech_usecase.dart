import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/usecase/core_usecase.dart';
import 'package:saathi_assignment/core/utils/failure.dart';
import 'package:saathi_assignment/features/translate/domain/repository/translate_repository.dart';

class TranslateToSpeechUsecase
    implements CoreUsecases<String, TranslateToSpeechParams> {
  final TranslateRepository translateRepository;

  TranslateToSpeechUsecase(this.translateRepository);
  @override
  Future<Either<Failure, String>> call(TranslateToSpeechParams input) async {
    return await translateRepository.translateTextToSpeech(
        input.text, input.languageCode);
  }
}

class TranslateToSpeechParams {
  final String text;
  final String languageCode;

  TranslateToSpeechParams({required this.text, required this.languageCode});
}
