import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/theme.dart';
import 'utils/constants.dart';
import 'views/root_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JalSetuApp());
}

class JalSetuApp extends StatelessWidget {
  const JalSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const RootView(),
    );
  }
}

