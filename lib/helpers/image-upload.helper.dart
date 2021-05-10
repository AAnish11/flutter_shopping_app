import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker picker = ImagePicker();
class Helper {
  static Future<String> uploadImage(io.File _imageFile) async {
    try {
      final fileName = '${DateTime.now().toString()}.png';
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      SettableMetadata finalMeta = SettableMetadata(
          contentType: 'image/png',
          customMetadata: {'picked-file-path': _imageFile.path });
      UploadTask uploadTask =
          firebaseStorageRef.putFile(io.File(_imageFile.path), finalMeta);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      final String url = await taskSnapshot.ref.getDownloadURL();
      return Future.value(url);
    } catch (err) {
      throw err;
    }
  }

  static Future<PickedFile> getPickedImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return Future.value(pickedFile);
  }
}
