import 'package:get_storage/get_storage.dart';

class FingerPrintServices {
  final _box = GetStorage();
  final _key = "FINGER_PRINT";
  bool loadPrintFromBox() => _box.read(_key) ?? false;
  void savePrintToBox(bool isPrint) => _box.write(_key, isPrint);
}
