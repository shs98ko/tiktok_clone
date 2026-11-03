/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { setGlobalOptions } from "firebase-functions";
// import {onRequest} from "firebase-functions/https";
// import * as logger from "firebase-functions/logger";
import {
  onDocumentCreated,
  onDocumentDeleted,
} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({ maxInstances: 10 });

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

export const onVideoCreated = onDocumentCreated(
  { document: "videos/{videoId}", memory: "1GiB" },
  async (event) => {
    const snapshot = event.data;
    if (!snapshot) return;

    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    await spawn("ffmpeg", [
      "-i",
      video.fileUrl,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      `/tmp/${snapshot.id}.jpg`,
    ]);
    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });
    const db = admin.firestore();
    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
      });
  },
);

export const onLikedCreated = onDocumentCreated(
  "likes/{likeId}",
  async (event) => {
    const db = admin.firestore();
    const [videoId, userId] = event.params.likeId.split("000");

    const videoRef = db.collection("videos").doc(videoId);
    await videoRef.update({
      likes: admin.firestore.FieldValue.increment(1),
    });

    // 영상 정보를 읽어서 유저의 likes 아래에 복사
    const video = (await videoRef.get()).data();
    if (!video) return;
    await db
      .collection("users")
      .doc(userId)
      .collection("likes")
      .doc(videoId)
      .set({
        videoId,
        thumbnailUrl: video.thumbnailUrl,
      });
  },
);

export const onLikedRemoved = onDocumentDeleted(
  "likes/{likeId}",
  async (event) => {
    const db = admin.firestore();
    const [videoId, userId] = event.params.likeId.split("000");

    await db
      .collection("videos")
      .doc(videoId)
      .update({ likes: admin.firestore.FieldValue.increment(-1) });

    await db
      .collection("users")
      .doc(userId)
      .collection("likes")
      .doc(videoId)
      .delete();
  },
);
