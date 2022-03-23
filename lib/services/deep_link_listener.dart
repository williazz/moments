import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';
import 'package:moments/util/show_alert_dialog.dart';

listenForDeepLinks() {
  final auth = FirebaseAuth.instance;
  final router = GetIt.I<AppRouter>();
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
    final link = dynamicLinkData.link.toString();
    final emailController = GetIt.I<AuthService>().emailController;
    if (auth.isSignInWithEmailLink(link)) {
      try {
        await auth.signInWithEmailLink(
            email: emailController.text, emailLink: link);
        emailController.clear();
        router.replaceAll([const RegisterRouter()]);
      } catch (e) {
        final context = router.navigatorKey.currentContext;
        if (context != null) {
          showAlertDialog(
              context: context, title: 'Failed to sign in with email link');
        }
      }
    }
  }).onError((e) {
    final context = router.navigatorKey.currentContext;
    if (context != null) {
      showAlertDialog(
          context: context, title: 'Failed to sign in with email link');
    }
  });
}
