import 'package:uuid/uuid.dart';

class Utils {
  static String generateUUID() {
    var uuidGenerator = const Uuid();
    return uuidGenerator.v4();
  }
}
