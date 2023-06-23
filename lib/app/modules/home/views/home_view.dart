import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player_task/app/core/functions/get_user_image.dart';
import 'package:video_player_task/app/core/functions/logout.dart';
import 'package:video_player_task/app/core/storage.dart';
import 'package:video_player_task/app/modules/settings/views/settings_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        drawer: Drawer(
          backgroundColor: const Color(0xFF081C36),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 200,
                color: const Color(0xFF081C36),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FutureBuilder<String?>(
                          future: getStringValue('imageUrl'),
                          builder: (context, snap) {
                            print('image url ${snap.data}');
                            if (snap.data != null) {
                              return FutureBuilder<String?>(
                                  future: retrieveUserImage(snap.data!),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            NetworkImage(snapshot.data!),
                                      );
                                    }
                                    return const SizedBox();
                                  });
                            }

                            return const SizedBox();
                          }),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.toNamed('/user-info');
                },
              ),
              ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsView(),
                        ));
                  }),
              ListTile(
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  logout();
                },
              ),
            ],
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: theme.iconTheme,
          elevation: 0,
          backgroundColor: theme.appBarTheme.backgroundColor,
          actions: const [
            CircleAvatar(),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Obx(
          () => SafeArea(
            child: Column(
              children: [
                controller.isLoading.value
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            if (controller.isVideoPlayerInitialized.value)
                              AspectRatio(
                                aspectRatio: controller
                                    .videoPlayerController.value.aspectRatio,
                                child: Chewie(
                                  controller: controller.chewieController,
                                ),
                              )
                            else
                              const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text('Click on Download Button'),
                                ),
                              ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.replay_5),
                                      color: Colors.white,
                                      onPressed: controller.seekBackward,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.forward_5),
                                      color: Colors.white,
                                      onPressed: controller.seekForward,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 33,
                      width: 35,
                      child: Material(
                        color: theme.secondaryHeaderColor,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(
                            child: Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                        )),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.downloadVideos();
                          ();
                        },
                        child: const Text('Download')),
                    SizedBox(
                      height: 33,
                      width: 35,
                      child: Material(
                        color: theme.secondaryHeaderColor,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: const Center(
                            child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
