import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repository/playback_config_repo.dart';
/*
RiverPod : 관심사 분리를 가능하도록 함에 있어서 provider와 비슷하지만 
View로직과 Business로직을 각기 다른 곳에 위치하게 만들어주고 
dependency들을 주입시켜서 Provider들을 어디에서나 읽을 수 있도록 한다. 
또한 어플리케이션을 전체 렌더링할 필요없이 값들의 변화를 listen할 수 있다.
*/

//- Notifier에게 이 데이터를 expose하게 될 거라고 알려주기위해 데이터타입을 적어준다
//  (이때 데이터는 우리가 화면이 listen하고 watch하기를 원하는 데이터이다)
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);

    //- state는 사용자에게 노출시키고 싶은 데이터이다
    //단, state는 mutate할 수 없기에(바꿀 수 없다) 새로운 state를 만들어 기존 state를 대체해야 한다.
    //이때 모든화면이 새로고침하는 때가 됨
    state = PlaybackConfigModel(muted: value, autoplay: state.autoplay);
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.muted, autoplay: value);
  }

  //- Notifier.build는 화면이 보기를 원하는 데이터를 초기화하는 메소드이다
  //  firbase로부터 데이터를 가져와 데이터를 build하고, 그 데이터를 사용자의 프로필 화면에 노출시킨다
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

/* 
Provider를 만들 때 두개의 타입을 적는다
1. 우리가 expose하고 싶은 provider 
2. Provider가 expose할 데이터 
 */
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
      () => throw UnimplementedError(),
    );
