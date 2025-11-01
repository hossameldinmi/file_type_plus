import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:file_type_plus/file_type_plus.dart';

class FileType extends Equatable {
  final String value;
  final Map<String, String> extensionMap;

  FileType._(ExtensionGroupFilter groupFilter)
      : value = groupFilter.name,
        extensionMap = ExtensionsGrouping.categorizedExtensions[groupFilter.name]!;

  bool isAny(List<FileType> list) => list.map((e) => e.value).contains(value);
  bool isAnyType(List<Type> list) => list.contains(runtimeType);

  static final image = FileType._(ExtensionGroupFilter.image);
  static final audio = FileType._(ExtensionGroupFilter.audio);
  static final video = FileType._(ExtensionGroupFilter.video);
  static final document = FileType._(ExtensionGroupFilter.document);
  static final html = FileType._(ExtensionGroupFilter.html);
  static final archive = FileType._(ExtensionGroupFilter.archive);
  static final other = FileType._(ExtensionGroupFilter.other);

  /// Create a FileType from a file extension or MIME type using the extension maps.
  factory FileType.fromExtensionOrMime({String? extension, String? mimeType}) {
    extension = extension?.toLowerCase();
    mimeType = mimeType?.toLowerCase();
    if (extension != null || mimeType != null) {
      for (var fileType in values) {
        if (extension != null && fileType.extensionMap.containsKey(extension)) {
          return fileType;
        }
        if (mimeType != null && fileType.extensionMap.containsValue(mimeType)) {
          return fileType;
        }
      }
    }
    return other;
  }
  factory FileType.fromPath(String path, [String? mimeType]) {
    final uri = Uri.parse(path);
    if (mimeType != null) return FileType.fromExtensionOrMime(mimeType: mimeType);
    mimeType = FileUtil.getMimeTypeFromPath(uri.path);
    return FileType.fromExtensionOrMime(mimeType: mimeType);
  }

  factory FileType.fromBytes(Uint8List bytes, [String? mimeType]) {
    if (mimeType != null) return FileType.fromExtensionOrMime(mimeType: mimeType);
    mimeType = FileUtil.getMimeTypeFromBytes(bytes);
    return FileType.fromExtensionOrMime(mimeType: mimeType);
  }

  @override
  List<Object?> get props => [value];

  static final values = [image, audio, video, document, html, archive, other];
}
