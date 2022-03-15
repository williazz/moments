import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';
import 'package:moments/util/show_alert_dialog.dart';

signoutAndNavAway(BuildContext context) async {
  final getIt = GetIt.I;
  final auth = getIt<AuthService>();
  final router = getIt<AppRouter>();
  try {
    await auth.signOut();
    router.replaceAll(const [AuthRouter()]);
  } catch (_) {
    showAlertDialog(context: context, title: 'Unable to sign out');
  }
}
