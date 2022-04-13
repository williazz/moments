import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/util/show_danger_dialog.dart';
import 'package:moments/util/signout.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool rootLevel;
  final String title;
  const CustomAppBar({
    Key? key,
    this.rootLevel = false,
    String? title,
  })  : title = title ?? 'Ocracy',
        super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  State<CustomAppBar> createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.dialogBackgroundColor,
      foregroundColor: theme.colorScheme.onSurface,
      shadowColor: theme.shadowColor.withOpacity(0.15),
      leading: widget.rootLevel
          ? IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(CupertinoIcons.circle))
          : null,
      centerTitle: true,
      title: widget.rootLevel ? Text(widget.title) : null,
      actions: [
        IconButton(
          onPressed: _showModal,
          icon: const Icon(CupertinoIcons.ellipsis),
        ),
      ],
    );
  }

  _showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        )),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return const _OptionsMenu();
        });
  }
}

class _OptionsMenu extends StatelessWidget {
  const _OptionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
              onTap: () {
                showDangerDialog(context, () => signoutAndNavAway(context));
              },
              child: const ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Logout'),
              )),
          const Divider(),
        ],
      ),
    );
  }
}
