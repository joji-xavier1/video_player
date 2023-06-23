import 'package:firebase_storage/firebase_storage.dart';

Future<String?> retrieveUserImage(String imageUrl) async {
  try {
    final imageRef = FirebaseStorage.instance.refFromURL(imageUrl);

    final downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error retrieving user image: $e');
    return null;
  }
}
