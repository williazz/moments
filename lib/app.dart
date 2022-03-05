import 'package:flutter/material.dart';
import 'package:moments/services/auth/link_sent.dart';

class MomentsApp extends StatelessWidget {
  const MomentsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moments',
      home: LinkSentPage(
        email: 'williamz.zhou1@gmail.com',
      ),
    );
  }
}
