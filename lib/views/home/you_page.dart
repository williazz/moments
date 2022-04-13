import 'package:flutter/material.dart';
import 'package:moments/components/appbar.dart';
import 'package:moments/components/profile_drawer.dart';
import 'package:moments/components/reply_modal/repliable_feed_widget.dart';
import 'package:moments/services/register.dart';
import 'package:provider/provider.dart';

class YouPage extends StatelessWidget {
  const YouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<RegisterService>(builder: (_, register, __) {
      final username = register.profile?.username;

      return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: CustomAppBar(rootLevel: true, title: username),
        drawer: const ProfileDrawer(),
        body: username != null
            ? RepliableFeedWidget(username: username)
            : const Center(
                child: Text('Account not registered'),
              ),
      );
    });
  }
}
