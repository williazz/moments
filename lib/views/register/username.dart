import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/services/register.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final usernameController = GetIt.I<RegisterService>().usernameController;

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(3 * gap),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Choose your username', style: textTheme.headline5),
            const SizedBox(height: gap),
            TextField(
              autofocus: true,
              controller: usernameController,
              onChanged: (_) => _validateAfterPause(),
              autofillHints: const [AutofillHints.newUsername],
              decoration: InputDecoration(
                label: const Text('Your username'),
                errorText: _errorText,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_fetching)
                      const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.grey)),
                    if (valid)
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    IconButton(
                        key: const ValueKey('username-clear-button'),
                        onPressed: () {
                          _reset();
                          usernameController.clear();
                          setState(() {});
                        },
                        icon: const Icon(CupertinoIcons.clear_circled_solid)),
                  ],
                ),
              ),
              autocorrect: false,
              enableSuggestions: false,
            ),
            const SizedBox(height: 2 * gap),
            ElevatedButton(
                onPressed: valid ? () {} : null,
                child: const Padding(
                    padding: EdgeInsets.all(2 * gap), child: Text('Sign up'))),
          ]),
        ),
      ),
    );
  }

  bool _fetching = false;
  Timer? _timer;
  _validateAfterPause() {
    _reset();
    setState(() => _fetching = true);
    _timer = Timer(const Duration(milliseconds: 700), _validate);
  }

  String? _errorText;
  bool get valid =>
      !_fetching && _errorText == null && usernameController.text.isNotEmpty;
  _validate() async {
    if (usernameController.text.isEmpty) {
      setState(() {
        _errorText = 'Please enter a username';
        _fetching = false;
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _errorText = null;
        _fetching = false;
      });
    }
  }

  _reset() {
    _timer?.cancel();
    setState(() {
      _errorText = null;
      _fetching = false;
    });
  }
}
