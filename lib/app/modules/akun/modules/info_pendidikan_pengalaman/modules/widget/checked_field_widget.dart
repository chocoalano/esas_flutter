import 'package:flutter/material.dart';

class CheckedFieldWidget extends StatelessWidget {
  final bool isChecked;
  final String label;
  final IconData icon;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color? iconColor;
  final EdgeInsetsGeometry padding;

  const CheckedFieldWidget({
    super.key,
    required this.isChecked,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.activeColor = Colors.blue, // Default active color
    this.checkColor = Colors.white, // Default check color
    this.iconColor,
    this.padding = const EdgeInsets.all(8.0), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CheckboxListTile(
        value: isChecked,
        onChanged: onChanged,
        title: Text(label),
        secondary:
            Icon(icon, color: iconColor ?? Theme.of(context).iconTheme.color),
        activeColor: activeColor,
        checkColor: checkColor,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
