import '../network/dio_client.dart';
import '../utils/image_picker_service.dart';
import '../../features/history/data/history_local_service.dart';
import '../../features/scan/logic/scan_cubit.dart';
import '../../features/scan/data/repositories/scan_repository.dart';
import '../../features/scan/data/repositories/api_scan_repositry.dart';

// Auth imports
import '../../features/auth/data/repository/authrepository.dart';
import '../../features/auth/logic/auth_cubit.dart';

// History imports
import '../../features/history/logic/history_cubit.dart';

class ServiceLocator {
  static late final DioClient dioClient;
  static late final ImagePickerService pickerService;
  static late final HistoryLocalService historyService;

  // Repositories
  static late final ScanRepository scanRepository;
  static late final AuthRepository authRepository;

  static Future<void> setup({bool isMockMode = false}) async {
    // 1. Shared core network & storage services
    dioClient = DioClient();
    pickerService = ImagePickerService();
    historyService = HistoryLocalService();

    // 2. Real Auth Repository initialized
    authRepository = AuthRepository(dioClient: dioClient);

    // 3. Real Scan Repository (ML Classification)
    scanRepository = ApiScanRepository(dioClient: dioClient);
  }

  // Cubit Factories
  static ScanCubit createScanCubit() {
    return ScanCubit(
      scanRepository: scanRepository,
      pickerService: pickerService,
      historyService: historyService,
    );
  }

  static AuthCubit createAuthCubit() {
    return AuthCubit(authRepository: authRepository);
  }

  static HistoryCubit createHistoryCubit() {
    return HistoryCubit(historyService: historyService);
  }
}