import '../../constant.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String tooltip;
  final VoidCallback act;

  const CustomFloatingActionButton({
    super.key,
    required this.tooltip,
    required this.act,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: act,
      backgroundColor: primaryColor,
      tooltip: tooltip,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.add,
        color: bgColor,
      ),
    );
  }
}
