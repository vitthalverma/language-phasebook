import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saathi_assignment/core/utils/audio_service.dart';
import 'package:saathi_assignment/features/translate/domain/usecases/translate_text_to_text_usecase.dart';
import 'package:saathi_assignment/features/translate/domain/usecases/translate_to_speech_usecase.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  final TranslateTextToTextUsecase toTextUsecase;
  final TranslateToSpeechUsecase toSpeechUsecase;
  TranslateBloc(this.toTextUsecase, this.toSpeechUsecase)
      : super(TranslateInitial()) {
    //
    on<TextTotextTranslateEvent>((event, emit) async {
      emit(TranslateLoading());

      final result = await toTextUsecase(TextToTextTranslateParams(
        text: event.text,
        sourceCode: event.sourceCode,
        targetCode: event.targetCode,
      ));
      result.fold(
        (e) => emit(TranslateError(errorMessage: e.msg)),
        (text) => emit(TranslateTextSuccess(translatedText: text)),
      );
    });

    on<TextToSpeechTranslateEvent>((event, emit) async {
      emit(TranslateLoading());
      final result = await toSpeechUsecase(TranslateToSpeechParams(
          text: event.text, languageCode: event.languageCode));

      result.fold(
        (e) => emit(TranslateError(errorMessage: e.msg)),
        (data) {
          final audioService = AudioService();
          audioService.playAudio(data);
        },
      );
    });
  }
}
