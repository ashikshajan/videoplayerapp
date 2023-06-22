import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late FlickManager flickManager;
  late Timer videoChangeTimer;
  int? indexofvideo;
  bool screeenvisible = false;
  Duration? duration;
  dynamic downloadPerc;
  bool isDwnloading = false;

  List videoData = [
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/rio_from_above_compressed.mp4?raw=true",
    },
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true",
    },
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/iceland_compressed.mp4?raw=true",
    },
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/9th_may_compressed.mp4?raw=true",
    },
    {
      "url":
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    },
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/rio_from_above_compressed.mp4?raw=true",
    },
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/iceland_compressed.mp4?raw=true",
    },
    {
      "url":
          "https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true",
    },
  ];
  @override
  void onInit() {
    super.onInit();

    flickManager = FlickManager(
      autoPlay: true,
      videoPlayerController: VideoPlayerController.network(
        videoData[0]["url"],
      ),
    );
  }

  changevideo(index) async {
    indexofvideo = await index;
    screeenvisible = true;
    update();
    String nextVideoUrl = videoData[index]["url"];
    flickManager.handleChangeVideo(VideoPlayerController.network(nextVideoUrl),
        videoChangeDuration: duration, timerCancelCallback: (bool playNext) {
      videoChangeTimer.cancel();
    });
  }

  closescreenvisibility() {
    screeenvisible = false;

    flickManager.flickControlManager?.pause();
    update();
  }

  void downloadVideo(urllink) async {
    isDwnloading = true;
    final downloadUrl = urllink;
    const downloadPath = '/storage/emulated/0/Download';
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = 'video_$timestamp.mp4';
    final savedPath = '$downloadPath/$fileName';
    final directory = Directory(downloadPath);

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    try {
      final dio = Dio();
      await dio.download(downloadUrl, savedPath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          downloadPerc = '${(received / total * 100).toStringAsFixed(0)}%';
        }
        update();
        //CommonUtilities.alertdialog(Text("Downloading"), Text("$downloadPerc"));
      });

      isDwnloading = false;
      update();
      Get.snackbar(
        "Download complete",
        " Saved at: $savedPath",
        backgroundColor: Colors.white,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isDwnloading = false;
      update();
      Get.snackbar(
        "Error occurred during download:",
        " $e",
        backgroundColor: Colors.white,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      // CommonUtilities.toastMessage('Error occurred during download: $e');
    }
  }
}
