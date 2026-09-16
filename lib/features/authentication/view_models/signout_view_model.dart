import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class SignoutViewModel extends Notifier<void> {
  late final AuthenticationRepository _authRepo = ref.read(authRepo);
  @override
  void build() {}

  void signOut() {
    _authRepo.signOut();
  }
}

final signOutProvieder = NotifierProvider<SignoutViewModel, void>(
  SignoutViewModel.new,
);
