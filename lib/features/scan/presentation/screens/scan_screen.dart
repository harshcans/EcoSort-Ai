import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecosort/core/utils/image_picker_service.dart';
import '../widgets/scan_header.dart';
import '../widgets/scan_mode_toggle.dart';
import '../widgets/scan_controls.dart';
import '../widgets/scan_tips.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isCameraSelected = true;
  File? _pickedImage;
  bool _isLoading = false;

  final ImagePickerService _pickerService = ImagePickerService();

  Future<void> _handleImagePick(ImageSource source) async {
    setState(() => _isLoading = true);

    try {
      final File? image = await _pickerService.pickImage(source);
      if (image != null && mounted) {
        setState(() {
          _pickedImage = image;
        });
      }
    } catch (e) {
      debugPrint('Scan pick error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _removeImage() {
    if (_pickedImage != null) {
      try {
        if (_pickedImage!.existsSync()) {
          _pickedImage!.deleteSync();
        }
      } catch (e) {
        debugPrint('File deletion error: $e');
      }

      setState(() {
        _pickedImage = null;
      });
    }
  }

  void _onGetResult() {
    if (_pickedImage == null) return;
    debugPrint('Analyzing image at path: ${_pickedImage!.path}');
    // Model inference ya Result screen navigation
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScanHeader(),
              const SizedBox(height: 18),

              // Top Toggle: Camera & Gallery
              ScanModeToggle(
                isCameraSelected: _isCameraSelected,
                onToggle: (val) {
                  setState(() => _isCameraSelected = val);
                  if (!val) {
                    _handleImagePick(ImageSource.gallery);
                  }
                },
              ),
              const SizedBox(height: 18),

              // Viewport Box: Image preview
              Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _pickedImage != null
                      ? Image.file(
                          _pickedImage!,
                          width: double.infinity,
                          height: 230,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                            _isCameraSelected
                                ? Icons.camera_alt_outlined
                                : Icons.photo_library_outlined,
                            size: 54,
                            color: Colors.black38,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Get Result Button
              if (_pickedImage != null) ...[
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onGetResult,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Get Result',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Controls: Gallery, Shutter, Remove
              ScanControls(
                onGalleryTap: () {
                  setState(() => _isCameraSelected = false);
                  _handleImagePick(ImageSource.gallery);
                },
                onShutterTap: () {
                  setState(() => _isCameraSelected = true);
                  _handleImagePick(ImageSource.camera);
                },
                onRemoveTap: _removeImage,
              ),
              const SizedBox(height: 26),

              const ScanTips(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
