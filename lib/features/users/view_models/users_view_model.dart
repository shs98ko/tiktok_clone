import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authRepository = ref.read(authRepo);

    if (_authRepository.isLoggedIn) {
      final profile = await _userRepository.findProfile(
        _authRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    final form = ref.read(userForm);
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? "anon@anon.com",
      name: form["name"],
      bio: "undefined",
      link: "undefined",
      birthday: form["birthday"],
      hasAvatar: false,
    );
    state = AsyncValue.data(profile);

    await _userRepository.createProfile(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }

  Future<void> updateProfile() async {
    if (state.value == null) return;
    final form = ref.read(userForm);
    final current = state.value!; // loading 처리 전에 미리 캡처

    final newBio = (form["bio"] as String?)?.isNotEmpty == true
        ? form["bio"]
        : current.bio;
    final newLink = (form["link"] as String?)?.isNotEmpty == true
        ? form["link"]
        : current.link; // 이 코드 지금 view에서 적용되도록 고쳐야함

    state = AsyncValue.loading();
    state = AsyncValue.data(current.copyWith(bio: newBio, link: newLink));

    await _userRepository.updateUser(current.uid, {
      "bio": newBio,
      "link": newLink,
    });
  }
}

final userForm = StateProvider<Map<String, dynamic>>((ref) => {});
final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
