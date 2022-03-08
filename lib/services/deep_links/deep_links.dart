

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';

listenForDeepLinks() {
    final auth = FirebaseAuth.instance;
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final link = dynamicLinkData.link.toString();
      if (auth.isSignInWithEmailLink(link)) {
        GetIt.I<AppRouter>().replaceAll([const HomeRoute()]);
      }
    }).onError((e) {
      // handle error (e)
    });
  }