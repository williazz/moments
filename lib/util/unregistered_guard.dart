import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/router/router.gr.dart';
import 'package:moments/services/auth.dart';
import 'package:moments/services/register.dart';

/// User must be unregistered to pass this guard
class UnregisteredGuard extends AutoRouteGuard {
  final _auth = GetIt.I<AuthService>();
  final _register = GetIt.I<RegisterService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // _auth.user!.email;
    final authenticated = _auth.isAuthenticated;
    if (!authenticated) {
      router.replaceAll(const [AuthRouter()]);
      return resolver.next(false);
    }

    final registered = await _register.isRegistered;
    if (registered) {
      router.replaceAll(const [HomeRouter()]);
      return resolver.next(false);
    }
    return resolver.next(true);
  }
}
