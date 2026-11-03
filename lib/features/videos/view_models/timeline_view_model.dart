import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repository/videos_repo.dart';

//AsyncNotifier : api로부터 얻어온 값을 제공함
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;

  List<VideoModel> _list = [];
  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map((doc) => VideoModel.fromJson(doc.data()));
    return videos.toList();
  }

  //build메소드에서 우리가 원하는 api를 호출하고 데이터를 반환하면, 그 데이터는 우리의 porvider에 의해 expose됨
  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchVideos(
      lastItemCreatedAt: _list.last.createdAt,
    );
    state = AsyncValue.data([..._list, ...nextPage]);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
      () => TimelineViewModel(),
    );
