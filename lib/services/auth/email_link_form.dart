import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:moments/firebase_options.dart';

class EmailLinkAuthStatus extends StatefulWidget {
  const EmailLinkAuthStatus({Key? key}) : super(key: key);

  @override
  State<EmailLinkAuthStatus> createState() => EmailLinkAuthStatusState();
}

class EmailLinkAuthStatusState extends State<EmailLinkAuthStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: AuthFlowBuilder<EmailLinkFlowController>(
          config: DefaultFirebaseOptions.emailLinkProviderConfig,
          listener: (prev, next, controller) {},
          builder: (context, state, controller, _) {
            if (state is AwaitingEmailAndPassword) {
              return const Text('Awaiting');
            }
            if (state is AwaitingEmailVerification) {
              return const Text('Awaiting Email Verification');
            }

            if (state is SignedIn) {
              return const Text('Signed In');
            }
            return Text(state.toString());
          },
        ),
      ),
    );
  }
}
