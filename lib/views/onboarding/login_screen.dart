import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/exit_modal_button.dart';
import 'package:moments/util/show_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function(String email) signIn;
  const LoginScreen({
    Key? key,
    required this.signIn,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  bool _attemptingSignIn = false;
  bool _valid = false;
  bool get _locked => !_valid | _attemptingSignIn;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: const ExitModalButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(3 * gap),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Sign In with Magic Link', style: textTheme.headline5),
                const SizedBox(height: gap),
                Text('Login instantly without account registration',
                    style: textTheme.bodyText2),
                const SizedBox(height: gap),
                TextField(
                    autofocus: true,
                    controller: _email,
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.send,
                    onChanged: _validate,
                    onSubmitted: (_) => _submit(),
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        label: const Text('Your email'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _email.clear();
                              _validate(_email.text);
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
      await widget.signIn(_email.text);
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

  _validate(String email) {
    setState(() {
      _valid = EmailValidator.validate(_email.text, false, true);
    });
  }
}
