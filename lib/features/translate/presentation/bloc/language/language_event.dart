part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

final class FetchAllLanguagesEvent extends LanguageEvent {}
