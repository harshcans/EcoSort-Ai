import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick image from specified source and compress it
  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile == null) return null;

      final File originalFile = File(pickedFile.path);
      return await _compressFile(originalFile);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Clean all previous temporary scan images from cache
  static Future<void> cleanupTempScans() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final entities = tempDir.listSync();
      for (final entity in entities) {
        if (entity is File && entity.path.contains('waste_scan_')) {
          entity.deleteSync();
        }
      }
    } catch (e) {
      debugPrint('Error cleaning up temp scans: $e');
    }
  }

  /// Compress image with a unique timestamped path to prevent cache collisions
  Future<File> _compressFile(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();

      // Pehle purani temporary scan files delete karo taaki phone storage na bhare
      await cleanupTempScans();

      // Unique timestamped name taaki Flutter ImageCache fresh file render kare
      final String uniqueName =
          'waste_scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String targetPath = '${tempDir.path}/$uniqueName';

      final XFile? compressedXFile =
          await FlutterImageCompress.compressAndGetFile(
            file.absolute.path,
            targetPath,
            quality: 70,
            format: CompressFormat.jpeg,
          );

      return compressedXFile != null ? File(compressedXFile.path) : file;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return file;
    }
  }
}
