import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onRemove;
  final Color removeIconColor;

  const ActionButtonWidget({
    super.key,
    required this.formKey,
    required this.onRemove,
    this.removeIconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.remove_circle_outline, color: removeIconColor),
        ),
      ],
    );
  }
}
