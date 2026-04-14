import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/core_app_widget.dart';
import 'core/injection/core_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await CoreInjection.setupInjection();

  runApp(const CoreAppWidget());
}
