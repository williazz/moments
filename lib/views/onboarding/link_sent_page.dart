import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/services/auth.dart';
import 'package:open_mail_app/open_mail_app.dart';

class LinkSentPage extends StatelessWidget {
  final String email;
  const LinkSentPage({
    Key? key,
    @PathParam() required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetIt.I<AuthService>().email = email;
    return LinkSentScreen(
      key: key,
      email: email,
    );
  }
}

class LinkSentScreen extends StatefulWidget {
  final String email;
  const LinkSentScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<LinkSentScreen> createState() => _LinkSentScreenState();
}

class _LinkSentScreenState extends State<LinkSentScreen> {
  @override
  void initState() {
    super.initState();
    _openEmailApp(context);
  }

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(gap * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Check your email',
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: gap),
            RichText(
                text: TextSpan(
                    text: 'We sent an email to ',
                    style: textTheme.subtitle1,
                    children: [
                  TextSpan(
                      text: widget.email,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.blue,
                          )),
                ])),
            const SizedBox(height: gap),
            Text(
                'If nothing was received, please wait another few moments before trying again',
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: gap * 3),
            OutlinedButton.icon(
                onPressed: () => _openEmailApp(context),
                icon: const Icon(CupertinoIcons.mail),
                label: const Padding(
                  padding: EdgeInsets.all(gap * 2),
                  child: Text('Open email app'),
                )),
          ],
        ),
      ),
    );
  }

  _openEmailApp(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      _showNoMailAppsDialog(context);
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            title: 'Open Mail',
            mailApps: result.options,
          );
        },
      );
    }
  }

  void _showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
