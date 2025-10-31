// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:file_type/file_type.dart';

/// Examples of detecting file types from byte data.
void main() {
  print('=== Detecting from Bytes ===\n');

  // JPEG magic bytes (FF D8 FF)
  final jpegBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);
  final jpegType = FileType.fromBytes(jpegBytes);
  print('JPEG magic bytes -> ${jpegType.value}'); // image

  // PNG magic bytes (89 50 4E 47 0D 0A 1A 0A)
  final pngBytes = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
  final pngType = FileType.fromBytes(pngBytes);
  print('PNG magic bytes -> ${pngType.value}'); // image

  // PDF magic bytes (%PDF)
  final pdfBytes = Uint8List.fromList([0x25, 0x50, 0x44, 0x46, 0x2D]);
  final pdfType = FileType.fromBytes(pdfBytes);
  print('PDF magic bytes -> ${pdfType.value}'); // document

  print('\n=== With MIME Type Override ===\n');

  // Even with wrong bytes, MIME type takes precedence
  final withMime = FileType.fromBytes(
    Uint8List.fromList([0x00, 0x01, 0x02]),
    'audio/mpeg',
  );
  print('Unknown bytes + audio/mpeg MIME -> ${withMime.value}'); // audio

  print('\n=== Unknown Bytes ===\n');

  // Unknown byte patterns return 'other'
  final unknownBytes = Uint8List.fromList([0x00, 0x00, 0x00, 0x00]);
  final unknownType = FileType.fromBytes(unknownBytes);
  print('Unknown bytes -> ${unknownType.value}'); // other

  print('\n=== Reading Real Files ===\n');

  // Example: Read actual test files
  _tryReadFile('test/assets/001.mp3', 'MP3 audio file');
  _tryReadFile('test/assets/3.9M.JPG', 'JPEG image file');
  _tryReadFile('test/assets/File_1.pdf', 'PDF document');
  _tryReadFile('test/assets/dummy.mp4', 'MP4 video file');
  _tryReadFile('test/assets/photorealistic-view-tree-nature-with-branches-trunk.jpg', 'JPEG photo');

  print('\n=== Practical Example: File Upload Validation ===\n');

  // Simulate file upload validation
  _validateUpload(jpegBytes, 'photo.jpg', [FileType.image]);
  _validateUpload(pdfBytes, 'document.pdf', [FileType.document]);
  _validateUpload(jpegBytes, 'virus.exe', [FileType.image]); // Extension mismatch!
}

void _tryReadFile(String path, String description) {
  try {
    final file = File(path);
    if (file.existsSync()) {
      final bytes = file.readAsBytesSync();
      final fileType = FileType.fromBytes(bytes);
      print('$description: ${fileType.value}');
    }
  } catch (e) {
    // File not found, skip
  }
}

void _validateUpload(Uint8List bytes, String filename, List<FileType> allowedTypes) {
  final detectedType = FileType.fromBytes(bytes);
  final extensionType = FileType.fromPath(filename);

  print('\nValidating upload: $filename');
  print('  Detected from bytes: ${detectedType.value}');
  print('  Detected from extension: ${extensionType.value}');

  if (detectedType.isAny(allowedTypes)) {
    if (detectedType == extensionType) {
      print('  ✓ Valid upload');
    } else {
      print('  ⚠️  Warning: Extension mismatch!');
      print('     File content is ${detectedType.value} but extension suggests ${extensionType.value}');
    }
  } else {
    print('  ✗ Invalid: Only ${allowedTypes.map((t) => t.value).join(', ')} files allowed');
  }
}
