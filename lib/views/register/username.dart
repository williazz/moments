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
                suffix: _fetching ? _loaderIcon() : null,
                suffixIcon: _fetching ? null : _clearButton(),
              ),
              autocorrect: false,
              enableSuggestions: false,
            ),
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
  _validate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _errorText = usernameController.text.isEmpty ? null : 'Error Text';
      _fetching = false;
    });
  }

  _reset() {
    _timer?.cancel();
    setState(() {
      _errorText = null;
      _fetching = false;
    });
  }

  Widget _clearButton() {
    return IconButton(
        key: const ValueKey('username-clear-button'),
        onPressed: () {
          _reset();
          usernameController.clear();
        },
        icon: const Icon(CupertinoIcons.clear_circled_solid));
  }

  Widget _loaderIcon() {
    return const SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(),
    );
  }
}
