import 'package:flutter/material.dart';
import 'package:test_app/bootstrap.dart';
import 'package:test_app/sl/service_locator.dart';

void main() {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Bootstrap());
}
