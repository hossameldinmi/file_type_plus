// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Quick Start Guide for the file_type_plus package.
///
/// This example shows the most common use cases in a simple format.
///
/// For more detailed examples, see:
/// - basic_usage.dart
/// - path_detection.dart
/// - bytes_detection.dart
/// - filtering_files.dart
library quick_start;

import 'package:file_type_plus/file_type_plus.dart';

void main() {
  // 1. Detect from extension
  print('1. From Extension:');
  print('   .jpg -> ${FileType.fromExtensionOrMime(extension: 'jpg').value}');

  // 2. Detect from MIME type
  print('\n2. From MIME Type:');
  print('   image/jpeg -> ${FileType.fromExtensionOrMime(mimeType: 'image/jpeg').value}');

  // 3. Detect from path
  print('\n3. From Path:');
  print('   photo.jpg -> ${FileType.fromPath('photo.jpg').value}');

  // 4. Filter files
  print('\n5. Filter Files:');
  final files = ['photo.jpg', 'song.mp3', 'video.mp4', 'doc.pdf'];
  final images = files.where((f) => FileType.fromPath(f) == FileType.image).toList();
  print('   Images: $images');

  // 5. Multiple types
  print('\n6. Multiple Types:');
  final media = files.where((f) {
    final type = FileType.fromPath(f);
    return type.isAny([FileType.image, FileType.audio, FileType.video]);
  }).toList();
  print('   Media: $media');

  // 6. All types
  print('\n7. Available Types:');
  FileType.values.forEach((t) => print('   - ${t.value}'));
}
