// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type_plus/file_type_plus.dart';

/// Example of extending FileType using copy constructor
/// Useful for adding custom metadata or behavior to file types
class CustomMediaType extends FileType {
  final Map<String, dynamic> metadata;

  /// Create a custom media type by copying from an existing FileType
  CustomMediaType(FileType baseType, {required this.metadata}) : super.copy(baseType);

  @override
  String toString() => 'CustomMediaType($value, metadata: $metadata)';
}

/// Basic usage examples for the file_type_plus package.
void main() {
  print('=== Basic File Type Detection ===\n');

  // Detect from file extension
  final jpgType = FileType.fromExtensionOrMime(extension: 'jpg');
  print('jpg extension -> ${jpgType.value}'); // image

  final mp3Type = FileType.fromExtensionOrMime(extension: 'mp3');
  print('mp3 extension -> ${mp3Type.value}'); // audio

  final mp4Type = FileType.fromExtensionOrMime(extension: 'mp4');
  print('mp4 extension -> ${mp4Type.value}'); // video

  final pdfType = FileType.fromExtensionOrMime(extension: 'pdf');
  print('pdf extension -> ${pdfType.value}'); // document

  final zipType = FileType.fromExtensionOrMime(extension: 'zip');
  print('zip extension -> ${zipType.value}'); // archive

  print('\n=== Using MIME Types ===\n');

  // Detect from MIME type
  final imageMime = FileType.fromExtensionOrMime(mimeType: 'image/jpeg');
  print('image/jpeg -> ${imageMime.value}'); // image

  final audioMime = FileType.fromExtensionOrMime(mimeType: 'audio/mpeg');
  print('audio/mpeg -> ${audioMime.value}'); // audio

  final videoMime = FileType.fromExtensionOrMime(mimeType: 'video/mp4');
  print('video/mp4 -> ${videoMime.value}'); // video

  print('\n=== Case Insensitive ===\n');

  // Extensions are case-insensitive
  final upperCase = FileType.fromExtensionOrMime(extension: 'JPG');
  print('JPG (uppercase) -> ${upperCase.value}'); // image

  final mixedCase = FileType.fromExtensionOrMime(extension: 'Mp3');
  print('Mp3 (mixed case) -> ${mixedCase.value}'); // audio

  print('\n=== Extension vs MIME Type Priority ===\n');

  // Extension takes priority when both are provided
  final extensionPriority = FileType.fromExtensionOrMime(
    extension: 'jpg',
    mimeType: 'audio/mpeg',
  );
  print('jpg extension + audio/mpeg MIME -> ${extensionPriority.value}'); // image

  print('\n=== Using FileType.copy as Super Constructor ===\n');

  // FileType.copy can be used in custom classes as a super constructor
  // Pass an existing FileType instance (like FileType.video) to copy it
  final customVideo = CustomMediaType(FileType.video, metadata: {'duration': 120});
  print('Custom video type: ${customVideo.value}');
  print('Custom metadata: ${customVideo.metadata}');

  final customImage = CustomMediaType(FileType.image, metadata: {'width': 1920, 'height': 1080});
  print('Custom image type: ${customImage.value}');
  print('Custom metadata: ${customImage.metadata}');

  print('\n=== Unknown Types ===\n');

  // Unknown extensions return 'other'
  final unknown = FileType.fromExtensionOrMime(extension: 'xyz123');
  print('xyz123 (unknown) -> ${unknown.value}'); // other

  final unknownMime = FileType.fromExtensionOrMime(mimeType: 'application/x-unknown');
  print('application/x-unknown -> ${unknownMime.value}'); // other

  print('\n=== All Available Types ===\n');

  // List all available file types
  for (final type in FileType.values) {
    print('${type.value}: ${type.extensionMap.length} extensions');
  }
}
