import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saathi_assignment/bootstrap.dart';
import 'package:saathi_assignment/core/app/app.dart';
import 'package:saathi_assignment/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  unawaited(bootstrap(() => const App()));
}
