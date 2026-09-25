import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repository/videos_repo.dart';

class VideoUploadViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video) async {
    final user = ref.read(authRepo).user;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.uploadVideoFile(video, user!.uid);
    });
  }
}

final videoUploadProvider = AsyncNotifierProvider<VideoUploadViewModel, void>(
  () => VideoUploadViewModel(),
);
