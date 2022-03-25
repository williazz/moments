import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';

/// User must be unauthenticated to pass this guard
class UnauthGuard extends AutoRouteGuard {
  final _auth = GetIt.I<AuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authenticated = _auth.isAuthenticated;
    if (authenticated) {
      router.replaceAll(const [RegisterRouter()]);
      return resolver.next(false);
    }
    return resolver.next(true);
  }
}
