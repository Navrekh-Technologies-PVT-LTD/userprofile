import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
void showCustomDialog({
  required BuildContext context,
  required String title,
    String? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  String confirmText = 'OK',
  String cancelText = 'Cancel',
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        content: content!,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm!,
        onCancel: onCancel!,
      );
    },
  );
}
