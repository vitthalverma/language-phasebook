import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saathi_assignment/core/usecase/core_usecase.dart';
import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';
import 'package:saathi_assignment/features/translate/domain/usecases/fetch_all_languages_usecase.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final FetchAllLanguagesUsecase fetchAllLanguagesUsecase;

  LanguageBloc(this.fetchAllLanguagesUsecase) : super(LanguageInitial()) {
    on<FetchAllLanguagesEvent>((event, emit) async {
      final result = await fetchAllLanguagesUsecase(NoParams());
      result.fold(
        (e) => emit(LanguageError(errorMessage: e.msg)),
        (langs) => emit(LanguageLoaded(languages: langs)),
      );
    });
  }
}
