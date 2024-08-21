import 'package:fpdart/fpdart.dart';
import 'package:saathi_assignment/core/usecase/core_usecase.dart';
import 'package:saathi_assignment/core/utils/failure.dart';
import 'package:saathi_assignment/features/translate/domain/repository/translate_repository.dart';

class TranslateTextToTextUsecase
    implements CoreUsecases<String, TextToTextTranslateParams> {
  final TranslateRepository translateRepository;

  TranslateTextToTextUsecase(this.translateRepository);
  @override
  Future<Either<Failure, String>> call(TextToTextTranslateParams input) async {
    return await translateRepository.translateTextToText(
        input.sourceCode, input.targetCode, input.text);
  }
}

class TextToTextTranslateParams {
  final String text;
  final String sourceCode;
  final String targetCode;

  TextToTextTranslateParams(
      {required this.text, required this.sourceCode, required this.targetCode});
}
