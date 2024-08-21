import 'package:flutter/material.dart';
import 'package:saathi_assignment/features/translate/presentation/screens/home_screen.dart';
import 'package:saathi_assignment/features/translate/presentation/screens/speech_translate_screen.dart';
import 'package:saathi_assignment/features/translate/presentation/screens/text_translate_screen.dart';

const homeRoute = '/';
const textTranslateRoute = '/text';
const speechTranslateRoute = '/speech';

class AppRouter {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const HomeScreen();
          },
        );
      case textTranslateRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const TextTranslateScreen();
          },
        );
      case speechTranslateRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const SpeechTranslateScreen();
          },
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const HomeScreen();
          },
        );
    }
  }
}
