// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:file_type_plus/file_type_plus.dart';

/// Examples of detecting file types from file paths.
void main() {
  print('=== Detecting from File Paths ===\n');

  // Simple file paths
  final image = FileType.fromPath('photos/vacation.jpg');
  print('photos/vacation.jpg -> ${image.value}'); // image

  final audio = FileType.fromPath('/music/song.mp3');
  print('/music/song.mp3 -> ${audio.value}'); // audio

  final video = FileType.fromPath('./videos/movie.mp4');
  print('./videos/movie.mp4 -> ${video.value}'); // video

  print('\n=== URLs and Network Paths ===\n');

  // HTTP URLs
  final imageUrl = FileType.fromPath('https://example.com/image.png');
  print('https://example.com/image.png -> ${imageUrl.value}'); // image

  final videoUrl = FileType.fromPath('http://cdn.example.com/video.webm');
  print('http://cdn.example.com/video.webm -> ${videoUrl.value}'); // video

  print('\n=== Special Case: ISM Streaming ===\n');

  // ISM (IIS Smooth Streaming) is treated as video
  final ismPath = FileType.fromPath('http://streaming.example.com/video.ism/manifest');
  print('...video.ism/manifest -> ${ismPath.value}'); // video

  final ismUrl = FileType.fromPath('https://cdn.com/stream.ism');
  print('...stream.ism -> ${ismUrl.value}'); // video

  print('\n=== With Explicit MIME Type ===\n');

  // MIME type takes precedence
  final withMime = FileType.fromPath(
    'file.unknown',
    'image/jpeg',
  );
  print('file.unknown + image/jpeg MIME -> ${withMime.value}'); // image

  print('\n=== Complex Paths ===\n');

  // Paths with query parameters
  final withQuery = FileType.fromPath('download.php?file=document.pdf');
  print('download.php?file=document.pdf -> ${withQuery.value}');

  // Windows paths
  final windowsPath = FileType.fromPath(r'C:\Users\Documents\report.docx');
  print('C:\\Users\\Documents\\report.docx -> ${windowsPath.value}'); // document

  print('\n=== File Filtering Example ===\n');

  final files = [
    '/home/user/photo.jpg',
    '/home/user/song.mp3',
    '/home/user/video.mp4',
    '/home/user/document.pdf',
    '/home/user/archive.zip',
    '/home/user/page.html',
    '/home/user/data.json',
  ];

  // Group files by type
  final filesByType = <String, List<String>>{};
  for (final file in files) {
    final type = FileType.fromPath(file);
    filesByType.putIfAbsent(type.value, () => []).add(file);
  }

  filesByType.forEach((type, paths) {
    print('$type files:');
    for (final path in paths) {
      print('  - ${path.split('/').last}');
    }
  });

  print('\n=== Real-World Example: Media Gallery ===\n');

  final galleryFiles = [
    'DSC_001.JPG',
    'DSC_002.jpg',
    'video_2024.mp4',
    'audio_note.m4a',
    'screenshot.png',
    'recording.wav',
    'presentation.pptx',
  ];

  final mediaFiles = galleryFiles.where((file) {
    final type = FileType.fromPath(file);
    return type.isAny([FileType.image, FileType.video, FileType.audio]);
  }).toList();

  print('Media files in gallery:');
  for (final file in mediaFiles) {
    final type = FileType.fromPath(file);
    print('  $file (${type.value})');
  }
}
