import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/alert_dialog_component.dart';
import 'package:todo_list/components/text_title_component.dart';
import 'package:todo_list/providers/taks_provider.dart';
import 'package:todo_list/providers/theme_provider.dart';
import 'package:todo_list/theme/app_color.dart';
import 'package:todo_list/utils/utils.dart';

import 'package:todo_list/views/add_list_view.dart';
import 'package:todo_list/views/update_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaksProvider>(context);
    final themeColor = Theme.of(context).colorScheme;

    // Llamamos a loadTasks() solo si aún no se ha cargado
    if (!taskProvider.isLoaded) {
      taskProvider.loadTasks();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lista de tareas'),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<TaksProvider>(
        builder: (context, provider, _) {
          if (provider.tasks.isEmpty) {
            return const Center(child: Text('No hay tareas aún.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                final task = provider.tasks[index];
                final color = taskProvider.getPriorityColor(task.priority);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UpdateView(taks: task)));
                  },
                  onLongPress: () {
                    showDeleteDialog(context, () {
                      provider.deleteTask(task.id!);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 80,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: themeColor.secondary.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          task.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          task.descrip,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    currentMonth(task.date),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddListView()));
        },
        child: Icon(
          Icons.add,
          color: AppColor.color0xFFFFFFFF,
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  children: [
                    // Contenedor para centrar el texto
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Menú",
                          style: TextStyle(
                            fontSize: 20,
                            color: themeColor.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Botón en la esquina superior derecha
                    Positioned(
                      bottom: -5,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Cambiar tema",
                style: TextStyle(
                  fontSize: 18,
                  color: themeColor.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              ItemMenu(
                title: "Tema",
                onTap: () {
                  themeProvider.changeTheme();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const ItemMenu({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        height: 40,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          // color: isSelected ? theme.primary : theme.onPrimary,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: themeColor.onSecondary,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(Icons.color_lens),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: themeColor.onSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
