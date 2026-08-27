import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepo = AuthenticationRepository();

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = AsyncValue.loading();
    final form = ref.read(signUpForm);
    // await _authRepo.signUp(form["email"], form["password"]);
    // state = AsyncData(null);
    state = await AsyncValue.guard(
      () async => await _authRepo.signUp(form["email"], form["password"]),
    );
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
