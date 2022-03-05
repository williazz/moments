import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkSentPage extends StatelessWidget {
  final String email;
  const LinkSentPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const gap = 10.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(gap * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Check your email',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: gap),
            RichText(
                text: TextSpan(
                    text: 'We sent a magic login link to: ',
                    style: Theme.of(context).textTheme.subtitle1,
                    children: [
                  TextSpan(
                      text: email,
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
                onPressed: () {},
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
}
