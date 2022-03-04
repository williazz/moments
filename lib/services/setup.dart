import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moments/firebase_options.dart';

setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'williamz.zhou1@gmail.com', password: 'password');
    print('success');
  } catch (e) {
    print(e);
  }
}
