import 'dart:developer';

import 'package:flutter/material.dart';

void showDeleteDialog(BuildContext context, VoidCallback onDelete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final themeColor = Theme.of(context).colorScheme;
      return AlertDialog(
        title: const Text('¿Eliminar tarea?'),
        content: const Text('¿Estás seguro que deseas eliminar esta tarea?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: themeColor.onPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(
              'Eliminar',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
