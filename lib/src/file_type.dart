import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'file_util.dart';

class FileType extends Equatable {
  final String _value;
  const FileType._(this._value);
  FileType._fromEnum(FileType value) : this._(value._value);
  bool isAny(List<FileType> list) => list.map((e) => e._value).contains(_value);
  bool isAnyType(List<Type> list) => list.contains(runtimeType);
  static const image = FileType._('image');
  static const audio = FileType._('audio');
  static const video = FileType._('video');
  static const document = FileType._('doc');
  static const url = FileType._('url');
  static const other = FileType._('other');

  factory FileType.fromPath(String path, String? mimeType) {
    final uri = Uri.parse(path);
    if (uri.path.contains('ism')) return FileType.video;
    if (mimeType != null) return _getMediaType(mimeType);
    mimeType = FileUtil.getMimeTypeFromPath(uri.path);
    return _getMediaType(mimeType!);
  }

  factory FileType.fromBytes(Uint8List bytes, String? mimeType) {
    if (mimeType != null) return _getMediaType(mimeType);
    mimeType = FileUtil.getMimeTypeFromBytes(bytes);
    return _getMediaType(mimeType!);
  }

  static FileType _getMediaType(String mime) {
    late FileType mediaType;
    if (mime.contains('image')) {
      mediaType = FileType.image;
    } else if (mime.contains('audio')) {
      mediaType = FileType.audio;
    } else if (mime.contains('video') || mime.contains('mpegurl')) {
      // mpegurl is for m3u8
      mediaType = FileType.video;
    } else if (mime.contains('application/pdf')) {
      mediaType = FileType.document;
    } else {
      mediaType = FileType.other;
    }
    return mediaType;
  }

  @override
  List<Object?> get props => [_value];
}
