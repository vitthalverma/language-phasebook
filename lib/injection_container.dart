import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:saathi_assignment/features/translate/data/remote_data/language_remote_data.dart';
import 'package:saathi_assignment/features/translate/data/remote_data/translate_remote_data.dart';
import 'package:saathi_assignment/features/translate/data/repository/language_repository_impl.dart';
import 'package:saathi_assignment/features/translate/data/repository/translate_repository_impl.dart';
import 'package:saathi_assignment/features/translate/domain/repository/language_repository.dart';
import 'package:saathi_assignment/features/translate/domain/repository/translate_repository.dart';
import 'package:saathi_assignment/features/translate/domain/usecases/fetch_all_languages_usecase.dart';
import 'package:saathi_assignment/features/translate/domain/usecases/translate_text_to_text_usecase.dart';
import 'package:saathi_assignment/features/translate/domain/usecases/translate_to_speech_usecase.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/favourite_phase/bloc/favourite_phrase_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/language/language_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/translate/translate_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initTranslation();

  final httpClient = http.Client();
  sl.registerLazySingleton(() => httpClient);
}

void _initTranslation() {
  // Datasource
  sl
    ..registerFactory<LanguageRemoteData>(() => LanguageRemoteDataImpl(sl()))
    ..registerFactory<TranslateRemoteData>(() => TranslateRemoteDataImpl(sl()))

    // Repository
    ..registerFactory<LanguageRepository>(() => LanguageRepositoryImpl(sl()))
    ..registerFactory<TranslateRepository>(
        () => TranslateRepositoryImpl(sl(), sl()))
    // Usecases
    ..registerFactory(() => TranslateTextToTextUsecase(sl()))
    ..registerFactory(() => FetchAllLanguagesUsecase(sl()))
    ..registerFactory(() => TranslateToSpeechUsecase(sl()))

    // Bloc
    ..registerLazySingleton(() => TranslateBloc(sl(), sl()))
    ..registerLazySingleton(() => LanguageBloc(sl()))
    ..registerLazySingleton(() => FavouritePhraseBloc());
}
