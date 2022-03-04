import 'package:flutter/material.dart';

class MomentsApp extends StatelessWidget {
  const MomentsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moments',
      home: Scaffold(
        appBar: AppBar(title: const Text('Home')),
      ),
    );
  }
}
