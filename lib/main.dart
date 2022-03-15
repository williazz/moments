import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/app.dart';
import 'package:moments/services/auth.dart';
import 'package:moments/services/setup.dart';
import 'package:provider/provider.dart';

void main() async {
  await setup();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => GetIt.I<AuthService>()),
  ], child: MomentsApp()));
}
