import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/components/alert_dialog_component.dart';
import 'package:todo_list/components/button_piority_component.dart';
import 'package:todo_list/components/custom_button_component.dart';
import 'package:todo_list/components/text_title_component.dart';
import 'package:todo_list/enum/priority_enum.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/providers/add_provider.dart';
import 'package:todo_list/providers/taks_provider.dart';
import 'package:todo_list/providers/update_provider.dart';
import 'package:todo_list/utils/utils.dart';

class UpdateView extends StatelessWidget {
  final TaskModel taks;
  const UpdateView({super.key, required this.taks});

  @override
  Widget build(BuildContext context) {
    // final addProvider = Provider.of<AddProvider>(context);

    final updateProvider = Provider.of<UpdateProvider>(context);
    final taksProvider = Provider.of<TaksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Actulizar tarea"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Calendary(taks: taks),
                    FormText(taks: taks),
                    Row(
                      children: [
                        Expanded(
                          child: StartTime(
                            label: "Hora de inicio",
                            time: taks.startTime,
                            onTimeChanged: (newTime) {
                              updateProvider.selectedTimeStart = newTime;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: StartTime(
                            label: "Hora de final",
                            time: taks.endTime,
                            onTimeChanged: (newTime) {
                              updateProvider.selectedTimeEnd = newTime;
                            },
                          ),
                        ),
                      ],
                    ),
                    Priority(taks: taks),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButtonComponent(
                      title: "Actualizar",
                      onTap: () {
                        updateProvider.update(taks.id!);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButtonComponent(
                      title: "Eliminar",
                      onTap: () {
                        showDeleteDialog(context, () {
                          taksProvider.deleteTask(taks.id!);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Calendario
class Calendary extends StatelessWidget {
  final TaskModel taks;
  const Calendary({super.key, required this.taks});
  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<AddProvider>(context);

    final updateProvider = Provider.of<UpdateProvider>(context);
    final themeColor = Theme.of(context).colorScheme;
    final selectedDate = taks.date;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left,
                  size: 28, color: themeColor.primary),
              onPressed: () {
                // addProvider.previousMonth();
              },
            ),
            const SizedBox(width: 8),
            Text(
              currentMonth(selectedDate),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: themeColor.primary,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                size: 28,
                color: themeColor.primary,
              ),
              onPressed: () {
                addProvider.nextMonth();
              },
            ),
          ],
        ),

        // Lista de días del mes
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: addProvider.days.length,
            itemBuilder: (context, index) {
              final day = addProvider.days[index];
              final isSelected = selectedDate.day == day.day &&
                  selectedDate.month == day.month &&
                  selectedDate.year == day.year;

              return GestureDetector(
                onTap: () {
                  updateProvider.currentSelectedDate(day);
                },
                child: Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isSelected ? themeColor.primary : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E', 'es_ES').format(day).replaceFirstMapped(
                            RegExp(r'^\w'), (m) => m.group(0)!.toUpperCase()),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? themeColor.primary
                              : themeColor.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('dd', 'es_ES').format(day), // Ej: 17
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? themeColor.primary
                              : themeColor.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FormText extends StatelessWidget {
  final TaskModel taks;
  const FormText({super.key, required this.taks});

  @override
  Widget build(BuildContext context) {
    // final addProvider = Provider.of<AddProvider>(context);
    final updateProvider = Provider.of<UpdateProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitleComponent(title: "Titulo y Descripción"),
          const SizedBox(height: 10),
          Form(
              child: Column(
            children: [
              TextField(
                controller: updateProvider.titleController,
                decoration: InputDecoration(hintText: taks.title),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: updateProvider.descController,
                maxLines: 4,
                decoration: InputDecoration(hintText: taks.descrip),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class StartTime extends StatelessWidget {
  final DateTime time;
  final void Function(DateTime) onTimeChanged;
  final String label;

  const StartTime({
    super.key,
    required this.time,
    required this.onTimeChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;

    // final addProvider = Provider.of<AddProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: themeColor.primary,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            final addProvider =
                Provider.of<AddProvider>(context, listen: false);
            addProvider.showTimePicker(context, time, (pickedTime) {
              onTimeChanged(pickedTime);
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: themeColor.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: themeColor.onSecondary),
                const SizedBox(width: 8),
                Text(
                  formatTime(time),
                  style: TextStyle(color: themeColor.onSecondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Priority extends StatelessWidget {
  final TaskModel taks;
  const Priority({super.key, required this.taks});

  @override
  Widget build(BuildContext context) {
    // final addProvider = Provider.of<AddProvider>(context);

    final updateProvider = Provider.of<UpdateProvider>(context);
    final selected = priorityFromString(taks.priority);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitleComponent(title: "Prioridad"),
          const SizedBox(height: 10),
          Row(
            children: PriorityEnum.values.map((priority) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ButtonPiorityComponent(
                    title: priority.label,
                    colorBorder: priority.borderColor,
                    isSelected: priority == selected,
                    onTap: () => updateProvider.setPriority(priority),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
