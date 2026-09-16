import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
  //stream을 이용하여 유저가 인증상태가 바뀔 때 앱을 실시간으로 새로고침할 수 있음
  // stream은 실시간 연결 같은 것( 변화를 바로 알 수 있는 UI와 백엔드 간의 연결)
  // 유저의 인증상태를 감지함
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
