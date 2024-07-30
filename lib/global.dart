import 'package:flutter/cupertino.dart';
import 'package:hcmus_alumni_mobile/common/services/storage_service.dart';

class Global {
  static late StorageService storageService;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService().init();
  }
}
