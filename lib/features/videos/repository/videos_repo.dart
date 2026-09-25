import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload a video file
  Future<void> uploadVideoFile(File video, String uid) async {
    final fileRef = _storage.ref().child(
      "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
    );
    await fileRef.putFile(video);
  }

  // create a video document
}

final videoRepo = Provider((ref) => VideosRepository());
