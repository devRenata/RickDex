import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick/src/core/dependency_injection.dart';
import 'package:rick/src/core/router.dart';
import 'package:rick/src/ui/themes/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DependencyInjection.initLocalStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DependencyInjection.createCharacterViewmodel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RickDex',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
