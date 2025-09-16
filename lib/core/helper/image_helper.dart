import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage({required ImageSource source}) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: source,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      final File? compressedFile = await _compressImage(imageFile);
      return compressedFile ?? imageFile;
    }
    return null;
  }

  static Future<File?> _compressImage(File file) async {
    final String targetPath =
        '${file.parent.path}/compressed_${file.uri.pathSegments.last}';

    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 600,
      minHeight: 800,
      format: CompressFormat.jpeg,
    );

    return result != null ? File(result.path) : null;
  }
}
