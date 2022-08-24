import 'package:flutter/material.dart';
import 'package:rickandmorty_ca_test/presentation/root.dart';
import 'package:rickandmorty_ca_test/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const Root());
}
