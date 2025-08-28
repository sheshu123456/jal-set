import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/app_theme.dart';
import 'views/shell/app_shell.dart';
import 'controllers/theme_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  runApp(const JalSetuApp());
}

class JalSetuApp extends GetView<ThemeController> {
  const JalSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Jal Setu',
        debugShowCheckedModeBanner: false,
        themeMode: controller.themeMode.value,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const AppShell(),
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}

