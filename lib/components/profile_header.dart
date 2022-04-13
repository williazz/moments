import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moments/components/rounded_button.dart';
import 'package:moments/util/number_format.dart';

class ProfileHeader extends StatefulWidget {
  final String username;
  const ProfileHeader({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final gap = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('@${widget.username}', style: theme.textTheme.headline6),
                SizedBox(height: gap),
                Row(children: [
                  Icon(CupertinoIcons.calendar,
                      size: 15, color: theme.hintColor),
                  Text(' Joined July 2010', style: theme.textTheme.bodySmall),
                ])
              ]),
              RoundedButton(
                title: 'Trust',
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: gap),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            ProfileStatWidget(label: 'Trustees', score: 999999),
            Text('  '),
            ProfileStatWidget(label: 'Trusting', score: 50),
          ]),
        ],
      ),
    );
  }
}

class ProfileStatWidget extends StatelessWidget {
  final String label;
  final int score;
  const ProfileStatWidget({
    Key? key,
    required this.label,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {},
      child: RichText(
        text: TextSpan(
            text: withCommas(score),
            style: theme.textTheme.bodyLarge,
            children: [
              TextSpan(text: ' $label', style: theme.textTheme.bodySmall)
            ]),
      ),
    );
  }
}
