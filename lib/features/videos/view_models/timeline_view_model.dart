import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

//AsyncNotifier : api로부터 얻어온 값을 제공함
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [VideoModel(title: "First Video")];
  //관심사분리 이론상 이 메소든 다른 modelview로 이동해야한다.
  Future<void> upoladVideo() async {
    state = AsyncValue.loading();
    await Future.delayed(Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    // state = _list (x)
    state = AsyncValue.data(_list);
  }

  //build메소드에서 우리가 원하는 api를 호출하고 데이터를 반환하면, 그 데이터는 우리의 porvider에 의해 expose됨
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
      () => TimelineViewModel(),
    );
