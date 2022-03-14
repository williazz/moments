import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';

// Redirects to home if the user is already authenticated
class UnauthGuard extends AutoRouteGuard {
  final _auth = GetIt.I<AuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(!_auth.isAuthenticated);
    if (_auth.isAuthenticated) {
      router.replaceAll(const [HomeRoute()]);
      resolver.next(false);
      return;
    }
    resolver.next(true);
  }
}
