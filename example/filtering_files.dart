// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type/file_type.dart';

/// Examples of filtering and categorizing files by type.
void main() {
  print('=== File Filtering Examples ===\n');

  final files = [
    'photo1.jpg',
    'photo2.png',
    'song1.mp3',
    'song2.wav',
    'video.mp4',
    'movie.avi',
    'report.pdf',
    'spreadsheet.xlsx',
    'archive.zip',
    'backup.tar.gz',
    'index.html',
    'page.htm',
    'script.js',
    'data.json',
  ];

  print('=== Filter by Single Type ===\n');

  // Filter only images
  final images = files.where((f) => FileType.fromPath(f) == FileType.image).toList();
  print('Images (${images.length}): $images');

  // Filter only audio
  final audio = files.where((f) => FileType.fromPath(f) == FileType.audio).toList();
  print('Audio (${audio.length}): $audio');

  // Filter only video
  final video = files.where((f) => FileType.fromPath(f) == FileType.video).toList();
  print('Video (${video.length}): $video');

  print('\n=== Filter by Multiple Types (isAny) ===\n');

  // Filter media files (images, audio, video)
  final mediaFiles = files.where((f) {
    final type = FileType.fromPath(f);
    return type.isAny([FileType.image, FileType.audio, FileType.video]);
  }).toList();
  print('Media files (${mediaFiles.length}): $mediaFiles');

  // Filter documents and archives
  final documentsAndArchives = files.where((f) {
    final type = FileType.fromPath(f);
    return type.isAny([FileType.document, FileType.archive]);
  }).toList();
  print('Documents & Archives (${documentsAndArchives.length}): $documentsAndArchives');

  print('\n=== Group by File Type ===\n');

  final groupedFiles = <String, List<String>>{};
  for (final file in files) {
    final type = FileType.fromPath(file);
    groupedFiles.putIfAbsent(type.value, () => []).add(file);
  }

  groupedFiles.forEach((type, fileList) {
    print('$type (${fileList.length}):');
    for (final file in fileList) {
      print('  - $file');
    }
  });

  print('\n=== Statistics ===\n');

  final stats = <String, int>{};
  for (final file in files) {
    final type = FileType.fromPath(file).value;
    stats[type] = (stats[type] ?? 0) + 1;
  }

  print('File type distribution:');
  stats.forEach((type, count) {
    final percentage = (count / files.length * 100).toStringAsFixed(1);
    print('  $type: $count ($percentage%)');
  });

  print('\n=== Real-World Example: Media Gallery ===\n');

  final galleryFiles = [
    'IMG_001.jpg',
    'IMG_002.JPG',
    'VID_001.mp4',
    'VID_002.MOV',
    'AUD_001.m4a',
    'README.txt',
    'backup.zip',
  ];

  print('Total files: ${galleryFiles.length}');

  final galleryImages = galleryFiles.where((f) => FileType.fromPath(f) == FileType.image).length;
  final galleryVideos = galleryFiles.where((f) => FileType.fromPath(f) == FileType.video).length;
  final galleryAudio = galleryFiles.where((f) => FileType.fromPath(f) == FileType.audio).length;
  final galleryOther = galleryFiles.length - galleryImages - galleryVideos - galleryAudio;

  print('Photos: $galleryImages');
  print('Videos: $galleryVideos');
  print('Audio: $galleryAudio');
  print('Other: $galleryOther');

  print('\n=== Advanced Filtering ===\n');

  // Custom filter: Only high-resolution image formats
  final highResFormats = ['png', 'tiff', 'raw', 'bmp'];
  final highResImages = files.where((f) {
    final type = FileType.fromPath(f);
    final extension = f.split('.').last.toLowerCase();
    return type == FileType.image && highResFormats.contains(extension);
  }).toList();
  print('High-resolution images: $highResImages');

  // Custom filter: Compressed archives only
  final compressedArchives = files.where((f) {
    final type = FileType.fromPath(f);
    final extension = f.split('.').last.toLowerCase();
    return type == FileType.archive && ['zip', 'rar', '7z', 'gz', 'bz2'].contains(extension);
  }).toList();
  print('Compressed archives: $compressedArchives');

  print('\n=== Exclude Certain Types ===\n');

  // Filter out archives and other types
  final noArchives = files.where((f) {
    final type = FileType.fromPath(f);
    return type != FileType.archive && type != FileType.other;
  }).toList();
  print('Files (excluding archives and other): $noArchives');
}
