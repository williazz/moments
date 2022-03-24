import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/services/register.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final register = GetIt.I<RegisterService>();
    return UsernameScreen(
      usernameController: register.usernameController,
      usernameIsAvailabe: register.usernameIsAvailable,
    );
  }
}

class UsernameScreen extends StatefulWidget {
  final TextEditingController usernameController;
  final Future<bool> Function(String username) usernameIsAvailabe;
  const UsernameScreen({
    Key? key,
    required this.usernameController,
    required this.usernameIsAvailabe,
  }) : super(key: key);

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
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
                controller: widget.usernameController,
                onChanged: (_) => _validateAfterPause(),
                autofillHints: const [AutofillHints.newUsername],
                decoration: InputDecoration(
                  label: const Text('Your username'),
                  errorText: _errorText,
                  suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
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
                          widget.usernameController.clear();
                          setState(() {});
                        },
                        icon: const Icon(CupertinoIcons.clear_circled_solid)),
                  ]),
                ),
                autocorrect: false,
                enableSuggestions: false),
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
      !_fetching &&
      _errorText == null &&
      widget.usernameController.text.isNotEmpty;

  _validate() async {
    if (widget.usernameController.text.isEmpty) {
      setState(() {
        _errorText = 'Please enter a username';
        _fetching = false;
      });
    } else {
      final isAvailable =
          await widget.usernameIsAvailabe(widget.usernameController.text);
      setState(() {
        _errorText = isAvailable ? null : 'Username is already taken!';
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
