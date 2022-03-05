import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

class LinkSentPage extends StatefulWidget {
  final String email;
  const LinkSentPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<LinkSentPage> createState() => _LinkSentPageState();
}

class _LinkSentPageState extends State<LinkSentPage> {
  @override
  void initState() {
    super.initState();
    _openEmailApp(context);
  }

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;
    final textTheme = Theme.of(context).textTheme;
    // TODO: change to use provided theme onPrimary
    // final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(gap * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Check your email',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: gap),
            RichText(
                text: TextSpan(
                    text: 'We sent a magic login link to: ',
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
                'If no email was received within a few moments, please double check the provided email and try again',
                style: Theme.of(context).textTheme.subtitle1),
            Expanded(child: Container()),
            OutlinedButton.icon(
                onPressed: () => _openEmailApp(context),
                icon: const Icon(CupertinoIcons.mail),
                label: const Padding(
                  padding: EdgeInsets.all(gap * 2),
                  child: Text('Open email app'),
                )),
            const SizedBox(height: gap * 3),
          ],
        ),
      ),
    );
  }

  _openEmailApp(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
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
