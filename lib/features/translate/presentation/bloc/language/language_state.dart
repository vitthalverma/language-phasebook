part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageLoading extends LanguageState {}

final class LanguageLoaded extends LanguageState {
  final List<LanguageEntity> languages;

  LanguageLoaded({required this.languages});
}

final class LanguageError extends LanguageState {
  final String errorMessage;

  LanguageError({required this.errorMessage});
}
