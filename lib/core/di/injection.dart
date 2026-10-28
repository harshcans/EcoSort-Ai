import '../network/dio_client.dart';
import '../utils/image_picker_service.dart';

// Scan imports
import '../../features/scan/logic/scan_cubit.dart';
import '../../features/scan/data/repositories/scan_repository.dart';
import '../../features/scan/data/repositories/api_scan_repositry.dart';

// Auth imports
import '../../features/auth/data/repository/authrepository.dart';
import '../../features/auth/logic/auth_cubit.dart';

// History imports
import '../../features/history/data/repo/scan_history_repository.dart';
import '../../features/history/logic/history_cubit.dart';

class ServiceLocator {
  static late final DioClient dioClient;
  static late final ImagePickerService pickerService;

  // Repositories
  static late final ScanRepository scanRepository;
  static late final AuthRepository authRepository;
  static late final ScanHistoryRepository scanHistoryRepository;

  static Future<void> setup({bool isMockMode = false}) async {
    // 1. Core singletons
    dioClient = DioClient();
    pickerService = ImagePickerService();

    // 2. Repositories initialization
    authRepository = AuthRepository(dioClient: dioClient);
    scanRepository = ApiScanRepository(dioClient: dioClient);
    scanHistoryRepository = ScanHistoryRepository(dioClient: dioClient);
  }

  // Factory methods for Cubits
  static ScanCubit createScanCubit() {
    return ScanCubit(
      scanRepository: scanRepository,
      pickerService: pickerService,
    );
  }

  static AuthCubit createAuthCubit() {
    return AuthCubit(authRepository: authRepository);
  }

  static HistoryCubit createHistoryCubit() {
    return HistoryCubit(repository: scanHistoryRepository);
  }
}