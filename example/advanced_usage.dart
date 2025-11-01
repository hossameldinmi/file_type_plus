// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type_plus/file_type_plus.dart';

/// Advanced examples showing various use cases.
void main() {
  print('=== Extension Map Exploration ===\n');

  // Get all extensions for a specific type
  final imageExtensions = FileType.image.extensionMap;
  print('Image extensions (${imageExtensions.length} total):');
  imageExtensions.entries.take(10).forEach((entry) {
    print('  .${entry.key} -> ${entry.value}');
  });
  print('  ... and ${imageExtensions.length - 10} more\n');

  print('=== Type Comparison ===\n');

  final file1 = FileType.fromExtensionOrMime(extension: 'jpg');
  final file2 = FileType.fromExtensionOrMime(extension: 'png');
  final file3 = FileType.fromExtensionOrMime(extension: 'mp3');

  print('jpg == png: ${file1 == file2}'); // true (both are images)
  print('jpg == mp3: ${file1 == file3}'); // false (different types)
  print('jpg == FileType.image: ${file1 == FileType.image}'); // true

  print('\n=== Using isAnyType ===\n');

  // Check if a type is in a list of Type objects
  final imageFile = FileType.image;
  print('Is FileType: ${imageFile.isAnyType([FileType])}'); // true
  print('Is String: ${imageFile.isAnyType([String])}'); // false
  print('Is int or FileType: ${imageFile.isAnyType([int, FileType])}'); // true

  print('\n=== All File Types ===\n');

  print('Available file types:');
  for (final type in FileType.values) {
    final extensionCount = type == FileType.other ? 0 : type.extensionMap.length;
    print('  ${type.value}: $extensionCount extensions');
  }

  print('\n=== Streaming Video Detection ===\n');

  // Special case: ISM streaming files
  final streamingUrls = [
    'https://cdn.example.com/video.ism/manifest',
    'http://stream.tv/show.ism/Manifest',
    'https://vod.service.com/movie.ism/QualityLevels(1000000)',
  ];

  print('Streaming URLs (ISM):');
  for (final url in streamingUrls) {
    final type = FileType.fromPath(url);
    print('  ${type.value}: $url');
  }

  // HLS streaming
  final hlsFile = FileType.fromExtensionOrMime(extension: 'm3u8');
  print('\nHLS playlist (.m3u8): ${hlsFile.value}'); // video

  print('\n=== Building a File Manager ===\n');

  final fileSystem = {
    'Documents': ['report.pdf', 'notes.txt', 'spreadsheet.xlsx'],
    'Pictures': ['photo1.jpg', 'photo2.png', 'screenshot.bmp'],
    'Music': ['song1.mp3', 'song2.flac', 'album.m4a'],
    'Videos': ['movie.mp4', 'clip.avi', 'recording.mov'],
    'Downloads': ['archive.zip', 'installer.exe', 'data.json'],
  };

  fileSystem.forEach((folder, files) {
    print('\n$folder:');
    final typeStats = <String, int>{};

    for (final file in files) {
      final type = FileType.fromPath(file).value;
      typeStats[type] = (typeStats[type] ?? 0) + 1;
      final icon = _getIcon(FileType.fromPath(file));
      print('  $icon $file ($type)');
    }
  });

  print('\n=== Content Type Headers ===\n');

  // Useful for HTTP responses
  final webFiles = {
    'index.html': 'text/html',
    'style.css': 'text/css',
    'script.js': 'text/javascript',
    'logo.png': 'image/png',
    'data.json': 'application/json',
  };

  print('Content-Type headers:');
  webFiles.forEach((file, mimeType) {
    final type = FileType.fromPath(file, mimeType);
    print('  $file');
    print('    Content-Type: $mimeType');
    print('    Category: ${type.value}');
  });

  print('\n=== Bulk File Validation ===\n');

  final uploads = [
    {'name': 'photo.jpg', 'type': 'image/jpeg'},
    {'name': 'video.mp4', 'type': 'video/mp4'},
    {'name': 'document.pdf', 'type': 'application/pdf'},
    {'name': 'script.exe', 'type': 'application/x-msdownload'},
  ];

  final allowedTypes = [FileType.image, FileType.video, FileType.document];

  print('Upload validation:');
  for (final upload in uploads) {
    final type = FileType.fromPath(upload['name']!, upload['type']);
    final allowed = type.isAny(allowedTypes);
    final status = allowed ? '✓' : '✗';
    print('  $status ${upload['name']} (${type.value})');
  }
}

String _getIcon(FileType type) {
  if (type == FileType.image) return '🖼️';
  if (type == FileType.audio) return '🎵';
  if (type == FileType.video) return '🎬';
  if (type == FileType.document) return '📄';
  if (type == FileType.html) return '🌐';
  if (type == FileType.archive) return '📦';
  return '📎';
}
