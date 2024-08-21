import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:saathi_assignment/bootstrap.dart';
import 'package:saathi_assignment/core/app/app.dart';
import 'package:saathi_assignment/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await dotenv.load(fileName: ".env");
  unawaited(bootstrap(() => const App()));
}
