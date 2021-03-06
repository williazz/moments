import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/util/show_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function(String email) signIn;
  final TextEditingController emailController;
  const LoginScreen({
    Key? key,
    required this.signIn,
    required this.emailController,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _attemptingSignIn = false;
  bool get valid => widget.emailController.text.isNotEmpty;
  bool get _locked => !valid | _attemptingSignIn;

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        title: const Text('Moments'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(3 * gap),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Sign In with Magic Link', style: textTheme.headline5),
                const SizedBox(height: gap),
                Text('Login instantly, even without registering!',
                    style: textTheme.bodyText2),
                const SizedBox(height: gap),
                TextField(
                    controller: widget.emailController,
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.send,
                    onChanged: (_) => update(),
                    onSubmitted: (_) => _submit(),
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        label: const Text('Your email'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              widget.emailController.clear();
                              update();
                            },
                            icon: const Icon(
                                CupertinoIcons.clear_circled_solid)))),
                const SizedBox(height: 2 * gap),
                ElevatedButton(
                    onPressed: _locked ? null : _submit,
                    child: const Padding(
                        padding: EdgeInsets.all(2 * gap),
                        child: Text('Email me a Magic Link'))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit() async {
    if (_locked) return;
    setState(() => _attemptingSignIn = true);
    try {
      await widget.signIn(widget.emailController.text);
      // TextInput.
    } on FirebaseAuthException catch (e) {
      showAlertDialog(
        context: context,
        title: 'Login Failed',
        content: e.message,
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Login failed',
        content: 'Internal error',
      );
    }
    setState(() => _attemptingSignIn = false);
  }

  update() {
    setState(() {});
  }
}
