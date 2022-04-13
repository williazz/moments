import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/util/show_danger_dialog.dart';
import 'package:moments/util/signout.dart';

class RootAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RootAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  State<RootAppBar> createState() => _RootAppBarState();
}

class _RootAppBarState extends State<RootAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: theme.colorScheme.onSurface,
      shadowColor: theme.shadowColor.withOpacity(0.25),
      leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(CupertinoIcons.circle)),
      centerTitle: true,
      title: const Text('Ocracy'),
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
