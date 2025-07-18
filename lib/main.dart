import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/providers/add_provider.dart';
import 'package:todo_list/providers/taks_provider.dart';
import 'package:todo_list/providers/theme_provider.dart';
import 'package:todo_list/providers/update_provider.dart';
import 'package:todo_list/views/add_list_view.dart';
import 'package:path/path.dart';
import 'package:todo_list/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  // // WidgetsFlutterBinding.ensureInitialized();
  // final path = join(await getDatabasesPath(), 'tasks.db');
  // await deleteDatabase(path); // ¡OJO! Esto borra todo
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => TaksProvider()),
      ChangeNotifierProvider(create: (_) => AddProvider()),
      ChangeNotifierProvider(create: (_) => UpdateProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Material App',
      home: HomeView(),
      theme: themeProvider.currentTheme,
    );
  }
}
