import '../network/dio_client.dart';
import '../utils/image_picker_service.dart';
import '../../features/history/data/history_local_service.dart';
import '../../features/scan/logic/scan_cubit.dart';
import '../../features/scan/data/repositories/scan_repository.dart';
import '../../features/scan/data/repositories/api_scan_repositry.dart';

// Auth imports
import 'package:ecosort/features/auth/data/repository/mockauthrepository.dart';
import 'package:ecosort/features/auth/data/repository/authrepository.dart';
import '../../features/auth/logic/auth_cubit.dart';

// history import

import '../../features/history/logic/history_cubit.dart';

class ServiceLocator {
  static late final DioClient dioClient;
  static late final ImagePickerService pickerService;
  static late final HistoryLocalService historyService;

  // Repositories
  static late final ScanRepository scanRepository;
  static late final AuthRepository authRepository;

  static Future<void> setup({bool isMockMode = true}) async{
    // 1. Shared core services
    dioClient = DioClient();
    pickerService = ImagePickerService();
    historyService = HistoryLocalService();

    // 2. Repository switch
    if (isMockMode) {
      scanRepository = MockScanRepository();
      authRepository = MockAuthRepository(); // Offline dummy auth
    } else {
      scanRepository = ApiScanRepository(dioClient: dioClient);
      // Kal jab real auth API banegi toh yahan: ApiAuthRepository(dioClient: dioClient) aayega
      authRepository = MockAuthRepository();
    }
  }

  // Scan Cubit Factory
  static ScanCubit createScanCubit() {
    return ScanCubit(
      scanRepository: scanRepository,
      pickerService: pickerService,
      historyService: historyService,
    );
  }

  // Auth Cubit Factory
  static AuthCubit createAuthCubit() {
    return AuthCubit(authRepository: authRepository);
  }

  // ServiceLocator class ke andar method add karo:
  static HistoryCubit createHistoryCubit() {
    return HistoryCubit(historyService: historyService);
  }
}
