import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  final String name;
  final String bio;
  final String link;
  const UserProfileEditScreen({
    super.key,
    required this.bio,
    required this.link,
    required this.name,
  });

  @override
  ConsumerState<UserProfileEditScreen> createState() =>
      _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends ConsumerState<UserProfileEditScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};
  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final state = ref.read(userForm.notifier).state;
        ref.read(userForm.notifier).state = {
          ...state,
          "bio": formData["bio"]!,
          "link": formData["link"]!,
        };
        ref.read(usersProvider.notifier).updateProfile();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(hintText: widget.bio),
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['bio'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(hintText: widget.link),
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['link'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: FormButton(buttonText: "Save", disabled: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
