import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moments/components/rounded_elevated_button.dart';
import 'package:moments/services/feed.dart';
import 'package:moments/util/show_alert_dialog.dart';
import 'package:moments/util/show_snackbar.dart';

class CreatePostModal extends StatefulWidget {
  const CreatePostModal({Key? key}) : super(key: key);

  @override
  State<CreatePostModal> createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  bool _attemptingSignin = false;
  bool get _valid => _titleController.text.isNotEmpty;
  bool get locked => !_valid || _attemptingSignin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _customAppBar(context),
              Expanded(child: _postForm(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  child: Text('Cancel', style: textTheme.button),
                  onPressed: _pop),
              RoundedElevatedButton(
                  title: 'Post', onPressed: locked ? null : _submit),
            ]));
  }

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Widget _postForm(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintColor = Theme.of(context).hintColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  autocorrect: true,
                  style: textTheme.headline6,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      hintStyle:
                          textTheme.headline6!.copyWith(color: hintColor),
                      hintText: 'Your title',
                      border: InputBorder.none),
                  minLines: 1,
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => setState(() {})),
              Expanded(
                child: TextFormField(
                  controller: _bodyController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  autocorrect: true,
                  decoration: const InputDecoration(
                    hintText: 'Optional body text',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _submit() async {
    if (locked) return;
    setState(() => _attemptingSignin = true);
    final feedService = GetIt.I<FeedService>();
    try {
      await feedService.add(_titleController.text, _bodyController.text);
      _pop();
      showSnackBar(context, 'Post created!');
      return;
    } catch (_) {
      setState(() => _attemptingSignin = false);
      showAlertDialog(context: context, title: 'Unable to post');
    }
  }

  _pop() {
    AutoRouter.of(context).pop();
  }
}
