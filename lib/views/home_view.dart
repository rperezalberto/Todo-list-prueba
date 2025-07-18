import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/alert_dialog_component.dart';
import 'package:todo_list/providers/taks_provider.dart';
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
      appBar: AppBar(title: const Text('Lista de tareas')),
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
                              color: themeColor.secondary,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddListView()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
