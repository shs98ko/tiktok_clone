import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repository/videos_repo.dart';

//AsyncNotifier : api로부터 얻어온 값을 제공함
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;

  List<VideoModel> _list = [];

  //build메소드에서 우리가 원하는 api를 호출하고 데이터를 반환하면, 그 데이터는 우리의 porvider에 의해 expose됨
  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    final result = await _repository.fetchVideos();
    final newList = result.docs.map((doc) => VideoModel.fromJson(doc.data()));
    _list = newList.toList();
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
      () => TimelineViewModel(),
    );
