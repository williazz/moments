import 'package:flutter/material.dart';
import 'package:moments/components/feed.dart';
import 'package:moments/services/register.dart';
import 'package:provider/provider.dart';

class YouPage extends StatelessWidget {
  const YouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<RegisterService, String?>(
        selector: (_, register) => register.profile?.username,
        builder: (_, username, __) {
          if (username == null) {
            return const Center(child: Text('Account not registered'));
          }
          return FeedWidget(username: username);
        },
      ),
    );
  }
}
