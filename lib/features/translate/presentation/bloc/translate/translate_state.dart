part of 'translate_bloc.dart';

@immutable
sealed class TranslateState {}

final class TranslateInitial extends TranslateState {}

final class TranslateLoading extends TranslateState {}

final class TranslateTextSuccess extends TranslateState {
  final String translatedText;
  TranslateTextSuccess({required this.translatedText});
}

final class TranslateError extends TranslateState {
  final String errorMessage;
  TranslateError({required this.errorMessage});
}
