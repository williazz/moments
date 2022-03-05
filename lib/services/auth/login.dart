import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Future<void> Function(String email) signIn;
  const LoginPage({
    Key? key,
    required this.signIn,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  bool _valid = false;

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
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(3 * gap),
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Sign In', style: textTheme.headline5),
                const SizedBox(height: gap),
                Text(
                    'Use our magic link to sign in instantly. No account registration required!',
                    style: textTheme.bodyText2),
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
                      label: const Text('Email'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _email.clear();
                            _validate(_email.text);
                          },
                          icon:
                              const Icon(CupertinoIcons.clear_circled_solid))),
                ),
                const SizedBox(height: 2 * gap),
                ElevatedButton(
                    onPressed: _valid ? _submit : null,
                    child: const Padding(
                      padding: EdgeInsets.all(2 * gap),
                      child: Text('Send me the Magic Link'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAuthFail({required String title, String? content}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: content == null ? null : Text(content),
          );
        });
  }

  _submit() async {
    try {
      await widget.signIn(_email.text);
    } catch (_) {
      _showAuthFail(title: 'Login failed', content: 'Internal error');
    }
  }

  _validate(String email) {
    setState(() {
      _valid = EmailValidator.validate(_email.text, false, true);
    });
  }
}
