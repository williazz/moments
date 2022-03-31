import 'package:flutter/material.dart';
import 'package:moments/repos/profiles.dart';
import 'package:moments/services/register.dart';
import 'package:provider/provider.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
            child: Column(
          children: [
            Selector<RegisterService, Profile?>(
              selector: (_, register) => register.profile,
              builder: (_, profile, __) {
                final username = profile?.username ?? 'guest';
                return ListTile(
                    title: Text(
                      username,
                      style: theme.textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('@$username'));
              },
            )
          ],
        )),
      ]),
    );
  }
}
