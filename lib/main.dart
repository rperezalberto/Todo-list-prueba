import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/add_provider.dart';
import 'package:todo_list/providers/taks_provider.dart';
import 'package:todo_list/providers/theme_provider.dart';
import 'package:todo_list/providers/update_provider.dart';
import 'package:todo_list/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  // final path = join(await getDatabasesPath(), 'tasks.db');
  // await deleteDatabase(path); // <-- BORRAR SOLO PARA TESTING INICIAL

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TaksProvider()),
        ChangeNotifierProvider(create: (_) => AddProvider()),
        ChangeNotifierProvider(create: (_) => UpdateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        if (!themeProvider.isLoaded) {
          // Tema aún cargando
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MaterialApp(
          title: 'Material App',
          theme: themeProvider.currentTheme,
          home: const HomeView(),
        );
      },
    );
  }
}
