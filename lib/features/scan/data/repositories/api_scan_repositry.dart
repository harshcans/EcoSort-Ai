import 'dart:io';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/waste_result_model.dart';
import 'scan_repository.dart';

class ApiScanRepository implements ScanRepository {
  final DioClient dioClient;

  ApiScanRepository({required this.dioClient});

  @override
  Future<WasteResultModel> classifyImage(File imageFile) async {
    // DioClient ka postMultipart khud FormData banayega aur central ApiException throw karega
    final response = await dioClient.postMultipart(
      ApiEndpoints.classifyWaste,
      file: imageFile,
      fileKey: 'image',
    );

    return WasteResultModel.fromJson(response.data);
  }
} 