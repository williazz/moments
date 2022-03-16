import 'package:flutter/material.dart';
import 'package:moments/components/appbar.dart';

class YouPage extends StatelessWidget {
  const YouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('Blank You Page')),
    );
  }
}
