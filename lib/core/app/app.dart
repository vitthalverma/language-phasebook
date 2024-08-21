import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:saathi_assignment/core/app/app_router.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/favourite_phase/bloc/favourite_phrase_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/language/language_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/translate/translate_bloc.dart';
import 'package:saathi_assignment/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<TranslateBloc>()),
            BlocProvider(create: (context) => sl<LanguageBloc>()),
            BlocProvider(create: (context) => sl<FavouritePhraseBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            theme: ThemeData(appBarTheme: const AppBarTheme(elevation: 0)),
            darkTheme: ThemeData.dark(),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      },
    );
  }
}
