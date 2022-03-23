import 'package:flutter/material.dart';
import 'package:moments/components/appbar.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('Username Page')),
    );
  }
}
