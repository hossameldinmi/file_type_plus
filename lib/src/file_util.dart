import 'package:mime/mime.dart';

abstract class FileUtil {
  static String? getMimeTypeFromPath(String path) => lookupMimeType(path);
  static String? getMimeTypeFromBytes(List<int> bytes) => lookupMimeType('test', headerBytes: bytes);
}
