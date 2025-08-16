// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

// class ImageHelper {
//   static Future<File?> pickImageFromGallery() async {
//     final XFile? pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedImage != null) {
//       final File imageFile = File(pickedImage.path);
//       final File? compressedFile = await _compressImage(imageFile);
//       return compressedFile ?? imageFile;
//     }
//     return null;
//   }

//   static Future<File?> _compressImage(File file) async {
//     final String targetPath =
//         '${file.parent.path}/compressed_${file.uri.pathSegments.last}';

//     final XFile? result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 40,
//       minWidth: 600,
//       minHeight: 800,
//     );

//     return result != null ? File(result.path) : null;
//   }
// }
