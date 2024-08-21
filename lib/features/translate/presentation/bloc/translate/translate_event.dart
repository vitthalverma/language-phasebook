part of 'translate_bloc.dart';

@immutable
sealed class TranslateEvent {}

final class TextTotextTranslateEvent extends TranslateEvent {
  final String text;
  final String sourceCode;
  final String targetCode;

  TextTotextTranslateEvent({
    required this.text,
    required this.sourceCode,
    required this.targetCode,
  });
}

final class TextToSpeechTranslateEvent extends TranslateEvent {
  final String text;
  final String languageCode;

  TextToSpeechTranslateEvent({required this.text, required this.languageCode});
}
