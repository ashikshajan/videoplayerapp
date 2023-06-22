import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:videoplayerapp/controllers/videocntrlr.dart';
import 'package:videoplayerapp/screens/splash/spalshscreen.dart';

import '../../Utilities/common.dart';
import '../../Utilities/sharedpref.dart';
import '../../controllers/dashboardctrl.dart';

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VideoController videocontroller = Get.put(VideoController());

    final dashctrl = Get.find<DashbrdController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () async {
                _drawerKey.currentState!.openDrawer();
              }),
          centerTitle: true,
          title: Text(
            "Video Player",
            style: CommonUtilities.dashboardtxt,
          ),
        ),
        drawer: GetBuilder<VideoController>(builder: (controller) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: CommonUtilities.primaryclr),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 36,
                        foregroundImage: AssetImage(
                            CommonUtilities.assetImage("avatar.png")),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text('Ashik Shajan \nashikshajan1@gmail.com \n29/04/1997',
                          style: dashctrl.themeModee == ThemeMode.light
                              ? CommonUtilities.drwertxt2
                              : CommonUtilities.drwertxt),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Settings",
                    style: CommonUtilities.dashboardtxt,
                  ),
                ),
                dashctrl.themeModee == ThemeMode.dark
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          dashctrl.changeTheme(ThemeMode.light);
                        },
                        child: ListTile(
                          dense: false,
                          title: Text(
                            "Light Mode",
                            style: CommonUtilities.drwertxt,
                          ),
                          trailing: const Icon(Icons.light_mode),
                        ))
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          dashctrl.changeTheme(ThemeMode.dark);
                        },
                        child: ListTile(
                          dense: false,
                          title: Text(
                            "Dark Mode",
                            style: CommonUtilities.drwertxt,
                          ),
                          trailing: const Icon(Icons.dark_mode),
                        ),
                      ),
                InkWell(
                  onTap: () async {
                    await videocontroller.closescreenvisibility();
                    await SharedPrefsUtil.remove(SharedPrefsUtil.login);
                    Get.offAll(const Splash());
                  },
                  child: ListTile(
                    dense: false,
                    title: Text(
                      "Logout",
                      style: CommonUtilities.drwertxt,
                    ),
                    trailing: const Icon(Icons.power_settings_new),
                  ),
                ),
              ],
            ),
          );
        }),
        key: _drawerKey,
        floatingActionButton:
            GetBuilder<VideoController>(builder: (controller) {
          return videocontroller.screeenvisible
              ? FloatingActionButton(
                  backgroundColor: CommonUtilities.primaryclr,
                  onPressed: () {
                    videocontroller.closescreenvisibility();
                  },
                  child: const Icon(Icons.close),
                )
              : Container();
        }),
        body: Column(
          children: [
            GetBuilder<VideoController>(builder: (controller) {
              return videocontroller.screeenvisible == true
                  ? SizedBox(
                      height: 250,
                      width: Get.width,
                      child: FlickVideoPlayer(
                        flickManager: videocontroller.flickManager,
                        flickVideoWithControls: const FlickVideoWithControls(
                          closedCaptionTextStyle: TextStyle(fontSize: 8),
                          controls: FlickPortraitControls(),
                        ),
                        flickVideoWithControlsFullscreen:
                            const FlickVideoWithControls(
                          controls: FlickLandscapeControls(),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 5,
                    );
            }),
            GetBuilder<VideoController>(builder: (controller) {
              return videocontroller.screeenvisible == true
                  ? SizedBox(
                      width: Get.width - 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (videocontroller.isDwnloading == false) {
                                if (videocontroller.indexofvideo! > 0) {
                                  videocontroller.indexofvideo =
                                      videocontroller.indexofvideo! - 1;
                                  videocontroller.changevideo(
                                      videocontroller.indexofvideo!);
                                }
                              }
                            },
                            child: const Card(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back_ios_new),
                            )),
                          ),
                          InkWell(
                            onTap: () async {
                              if (videocontroller.isDwnloading == false) {
                                dynamic index = videocontroller.indexofvideo!;

                                if (index != null) {
                                  videocontroller.downloadVideo(
                                      videocontroller.videoData[index]["url"]);
                                } else {
                                  Get.snackbar(
                                    "Alert",
                                    "Please Select a Video to download",
                                    backgroundColor: Colors.white,
                                    colorText: Colors.black,
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Alert",
                                  "Please wait till the Download Complete",
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: SizedBox(
                              height: 50,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                      child: videocontroller.isDwnloading ==
                                              false
                                          ? Row(
                                              children: [
                                                const Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                  size: 25,
                                                ),
                                                Text(
                                                  "Download",
                                                  style: CommonUtilities
                                                      .dashboardtxt,
                                                ),
                                              ],
                                            )
                                          : Text(
                                              "Downloading ... ${videocontroller.downloadPerc}",
                                              style:
                                                  CommonUtilities.dashboardtxt,
                                            )),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (videocontroller.isDwnloading == false) {
                                log("${videocontroller.indexofvideo!}............${videocontroller.videoData.length - 1}");
                                if ((videocontroller.indexofvideo!) <
                                    videocontroller.videoData.length - 1) {
                                  videocontroller.indexofvideo =
                                      videocontroller.indexofvideo! + 1;
                                  videocontroller.changevideo(
                                      videocontroller.indexofvideo!);
                                }
                              }
                            },
                            child: const Card(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_forward_ios),
                            )),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            }),
            Card(
              elevation: 1,
              child: SizedBox(
                  height: 60,
                  child: Center(
                      child: Text(
                    "Select Video From The List To Play",
                    style: CommonUtilities.dashboardtxt,
                  ))),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: videocontroller.videoData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GetBuilder<VideoController>(builder: (controller) {
                      return InkWell(
                        onTap: () async {
                          if (videocontroller.isDwnloading == false) {
                            await videocontroller.changevideo(index);
                          } else {
                            Get.snackbar("Alert !", "Please wait...",
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                snackPosition: SnackPosition.TOP);
                          }
                        },
                        child: ListTile(
                            leading: SizedBox(
                              height: 90,
                              width: 60,
                              child: Card(
                                color: CommonUtilities.primaryclr,
                                elevation: 2,
                                child: Center(
                                    child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ),
                            title: Text(
                              "Video Play List ${index + 1}",
                              //  "${videocontroller.videoData[index]["title"]}",
                              style: CommonUtilities.dashboardtxt,
                            )),
                      );
                    });
                  }),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       dashctrl.changeTheme(ThemeMode.light);
            //     },
            //     child: Text('Light theme')),
            // ElevatedButton(
            //     onPressed: () {
            //       dashctrl.changeTheme(ThemeMode.dark);
            //     },
            //     child: Text('Dark theme')),
          ],
        ),
      ),
    );
  }
}
