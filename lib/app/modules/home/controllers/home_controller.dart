import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  final isVideoPlayerInitialized = false.obs;
  final double _seekAmount =
      5.0; // Amount to seek forward/backward (in seconds)
  final count = 0.obs;
  final isLoading = false.obs;
  String videoFolderPath = '';

  Future<void> initializeVideoPlayer(String path) async {
    videoPlayerController = VideoPlayerController.file(
      File(path),
    );
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      // Customize other options as needed
      // See the ChewieController documentation for more details
    );

    isVideoPlayerInitialized.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    checkVideoIsAlredyInStorage();
  }

  void downloadVideos() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    videoFolderPath = '${appDocDir.path}/video';
    await Permission.storage.request();

    String videoPath = '$videoFolderPath/encrypted_video.mp4';

    if (await File(videoPath).exists()) {
      print('Video file already exists. Reading from file...');
      isLoading.value = true;

      decryptAndConvertVideo(videoPath);
    } else {
      print('Video file does not exist. Downloading...');
      isLoading.value = true;
      http.Response response = await http.get(Uri.parse(
          'https://drive.google.com/uc?export=download&id=1J-aUo_U4YotBfQ3H7dUeXWhHBtD71Xym'));
      if (response.statusCode == 200) {
        List<int> videoBytes = response.bodyBytes;
        enCriptFunction(videoBytes);
      } else {
        print(
            'Failed to download the video. Status code: ${response.statusCode}');
      }
    }
  }

  void enCriptFunction(List<int> videoBytes) async {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    Encrypter encrypter;
    Encrypted encrypted;

    // PKCS1 (Default)
    encrypter = Encrypter(AES(key));
    encrypted = encrypter.encryptBytes(videoBytes, iv: iv);

    print('PKCS1 (Default)');

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);

    // Save encrypted video to the "video" folder in app storage

    await Directory(videoFolderPath).create(recursive: true);
    String encryptedVideoPath = '$videoFolderPath/encrypted_video.mp4';
    await File(encryptedVideoPath).writeAsBytes(encrypted.bytes);

    print('Encrypted video saved to: $encryptedVideoPath');
    decryptAndConvertVideo(encryptedVideoPath);
  }

  void seekForward() {
    final newPosition = videoPlayerController.value.position +
        Duration(seconds: _seekAmount.toInt());
    videoPlayerController.seekTo(newPosition);
  }

  void seekBackward() {
    final newPosition = videoPlayerController.value.position -
        Duration(seconds: _seekAmount.toInt());
    videoPlayerController.seekTo(newPosition);
  }

  void decryptAndConvertVideo(String encryptedVideoPath) async {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    Encrypter encrypter = Encrypter(AES(key));

    // Read the encrypted video bytes
    File encryptedVideoFile = File(encryptedVideoPath);
    List<int> encryptedVideoBytes = await encryptedVideoFile.readAsBytes();
    Uint8List myUint8List = Uint8List.fromList(encryptedVideoBytes);
    // Decrypt the video bytes
    List<int> decryptedVideoBytes =
        encrypter.decryptBytes(Encrypted(myUint8List), iv: iv);

    // Save the decrypted video bytes to a new file
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String decryptedVideoPath = '${appDocDir.path}/video/decrypted_video.mp4';
    await File(decryptedVideoPath).writeAsBytes(decryptedVideoBytes);
    initializeVideoPlayer(decryptedVideoPath);
    isLoading.value = false;
    print('Decrypted video saved to: $decryptedVideoPath');
  }

  checkVideoIsAlredyInStorage() async {
    isLoading.value = true;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    videoFolderPath = '${appDocDir.path}/video';
    await Permission.storage.request();

    String videoPath = '$videoFolderPath/encrypted_video.mp4';

    if (await File(videoPath).exists()) {
      print('Video file already exists. Reading from file...');
      isLoading.value = false;

      decryptAndConvertVideo(videoPath);
    } else {
      isLoading.value = false;
    }
  }
}
