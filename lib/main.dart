import 'package:flutter/material.dart';
import 'core/core_app_widget.dart';
import 'core/injection/core_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CoreInjection.setupInjection();

  runApp(const CoreAppWidget());
}
