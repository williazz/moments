import 'package:flutter/material.dart';
import 'package:moments/services/auth/login.dart';

class MomentsApp extends StatelessWidget {
  const MomentsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moments',
      home: LoginPage(signIn: (email) async {
        await Future.delayed(const Duration(seconds: 1));
        throw 'err';
      }),
      // home: LinkSentPage(
      //   email: 'williamz.zhou1@gmail.com',
      // ),
    );
  }
}
