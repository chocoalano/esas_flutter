import '../../constant.dart';
import 'package:flutter/material.dart';

class GlobatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GlobatAppbar({
    super.key,
    required this.act,
    required this.title,
  });

  final String title;
  final VoidCallback act;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(
        title,
        style: const TextStyle(color: bgColor, fontFamily: 'PlusJakartaSans'),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: act,
          icon: const Icon(
            Icons.arrow_back,
            color: bgColor,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
