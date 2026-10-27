import 'dart:io';
import 'package:ecosort/core/network/api_endpoints.dart';
import 'package:ecosort/features/scan/data/models/waste_result_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecosort/core/utils/image_picker_service.dart';
import '../../../../core/network/dio_client.dart';
import 'scan_identifying_screen.dart';
import 'scan_result_screen.dart';
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
  bool _isAnalyzing = false;

  final ImagePickerService _pickerService = ImagePickerService();
  final DioClient _dioClient = DioClient();

  Future<void> _handleImagePick(ImageSource source) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final File? image = await _pickerService.pickImage(source);

      if (!mounted) return;

      if (image != null) {
        setState(() {
          _pickedImage = image;
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to select image. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );

      debugPrint('Image picker error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _confirmAndRemoveImage() async {
    if (_pickedImage == null) return;

    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Remove Image?',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Are you sure you want to remove the current image?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(
                'Cancel',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text(
                'Remove',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldRemove == true && mounted) {
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

  Future<void> _onGetResult() async {
    if (_pickedImage == null || _isAnalyzing) return;

    setState(() => _isAnalyzing = true);

    try {
      final response = await _dioClient.postMultipart(
        ApiEndpoints.classifyWaste,
        file: _pickedImage!,
        fileKey: 'image',
      );

      if (!mounted) return;

      final dynamic responseData = response.data;

      if (responseData is! Map) {
        throw Exception('Invalid response received from server.');
      }

      final Map<String, dynamic> json = Map<String, dynamic>.from(responseData);

      final result = WasteResultModel.fromJson(json);

      setState(() => _isAnalyzing = false);

      if (result.isClassified && result.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ScanResultScreen(
              scannedImage: _pickedImage,
              category: result.category,
              description: result.guidance?.summary,
              steps: result.guidance?.steps,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.message ??
                  'Unable to identify this image. Please try another photo.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() => _isAnalyzing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Agar analyze chal raha hai toh Fullscreen ScanIdentifyingScreen dikhao
    if (_isAnalyzing) {
      return const PopScope(
        canPop: false, // User analyzing ke dauraan back press na kare
        child: ScanIdentifyingScreen(),
      );
    }

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
              ScanControls(
                onGalleryTap: () {
                  setState(() => _isCameraSelected = false);
                  _handleImagePick(ImageSource.gallery);
                },
                onShutterTap: () {
                  setState(() => _isCameraSelected = true);
                  _handleImagePick(ImageSource.camera);
                },
                onRemoveTap: _confirmAndRemoveImage,
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
