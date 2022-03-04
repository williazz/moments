import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moments/firebase_options.dart';

setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
