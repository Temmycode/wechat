import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({super.key, required String message, bool isError = true})
    : super(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red.shade800 : Colors.green.shade800,
        duration: const Duration(seconds: 4),
        dismissDirection: DismissDirection.horizontal,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      );
}
