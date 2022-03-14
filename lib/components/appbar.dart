import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: colors.surface,
      leading: IconButton(
          color: colors.onSurface,
          onPressed: () {},
          icon: const Icon(CupertinoIcons.line_horizontal_3)),
      centerTitle: false,
      title: Text('Moments', style: TextStyle(color: colors.onSurface)),
      actions: [
        IconButton(
            color: colors.onSurface,
            onPressed: () {},
            icon: const Icon(CupertinoIcons.ellipsis)),
      ],
    );
  }
}
