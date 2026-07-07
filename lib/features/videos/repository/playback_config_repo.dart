import 'package:shared_preferences/shared_preferences.dart';
/* 
  아키텍쳐가 필요한 이유: 우리 코드를 어떤 패턴에 맞춰서 정리해야하기 때문에 필요하다.
  => 모든 로직을 stateful stateless widget에 넣는다면 관심사 분리를 할 수 없다
  관심사분리: 한 파일은 한가지 일만을 하고 그것만 잘해야 한다 (소프웨어의 설계의 기초조건)

  MVVM Architecture (Model - View - ViewModel)

  Flutter (MVVM)	| Spring Boot (MVC)	역할
  View	          | Controller + View(Thymeleaf 등)	화면(UI)
  ViewModel	      | Controller + Service 일부	화면 상태와 비즈니스 로직 관리
  Model	          | Entity, DTO, Repository, API Model	데이터

  [Spring MVC]

  Controller
      ↓
  Service
      ↓
  Repository

  [Flutter MVVM]

  View
      ↓
  ViewModel
      ↓
  Repository 
*/

class PlaybackConfigRepo {
  static const String _muted = "muted";
  static const String _autoplay = "autoplay";

  /* 
  shared_preferences:  간단한 데이터를 사용자의 기기 저장소에 persist 하는 역할과 사용자의 기기 저장소에서 데이터를 읽는 역할
  persist : 데이터를 프로그램보다 오래 살리는 것
  data persistence : 데이터 유지 
  */
  final SharedPreferences _preferences;

  PlaybackConfigRepo(this._preferences);

  // 1. 음소거 관련 데이터를 디스크에 저장하는 메소드
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  // 2. 자동재생 관련 데이터를 디스크에 저장하는 메소드
  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  // 3. 데이터 읽기
  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
