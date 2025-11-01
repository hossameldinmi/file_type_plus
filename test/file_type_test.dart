import 'package:file_type_plus/src/file_type.dart';
import 'package:test/test.dart';
import 'assets/fixture.dart';

void main() {
  group('FileType', () {
    group('static instances', () {
      test('image should have correct value', () {
        expect(FileType.image.value, equals('image'));
        expect(FileType.image.extensionMap.isNotEmpty, isTrue);
      });

      test('audio should have correct value', () {
        expect(FileType.audio.value, equals('audio'));
        expect(FileType.audio.extensionMap.isNotEmpty, isTrue);
      });

      test('video should have correct value', () {
        expect(FileType.video.value, equals('video'));
        expect(FileType.video.extensionMap.isNotEmpty, isTrue);
      });

      test('document should have correct value', () {
        expect(FileType.document.value, equals('document'));
        expect(FileType.document.extensionMap.isNotEmpty, isTrue);
      });

      test('html should have correct value', () {
        expect(FileType.html.value, equals('html'));
        expect(FileType.html.extensionMap.isNotEmpty, isTrue);
      });

      test('archive should have correct value', () {
        expect(FileType.archive.value, equals('archive'));
        expect(FileType.archive.extensionMap.isNotEmpty, isTrue);
      });

      test('other should have correct value', () {
        expect(FileType.other.value, equals('other'));
      });
    });

    group('fromExtensionOrMime', () {
      group('image types', () {
        test('should return image for jpg extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'jpg');
          expect(result, equals(FileType.image));
        });

        test('should return image for jpeg extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'jpeg');
          expect(result, equals(FileType.image));
        });

        test('should return image for png extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'png');
          expect(result, equals(FileType.image));
        });

        test('should return image for gif extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'gif');
          expect(result, equals(FileType.image));
        });

        test('should return image for webp extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'webp');
          expect(result, equals(FileType.image));
        });

        test('should return image for svg extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'svg');
          expect(result, equals(FileType.image));
        });

        test('should return image for image/jpeg MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'image/jpeg');
          expect(result, equals(FileType.image));
        });

        test('should return image for image/png MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'image/png');
          expect(result, equals(FileType.image));
        });

        test('should handle uppercase extensions', () {
          final result = FileType.fromExtensionOrMime(extension: 'JPG');
          expect(result, equals(FileType.image));
        });
      });

      group('audio types', () {
        test('should return audio for mp3 extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'mp3');
          expect(result, equals(FileType.audio));
        });

        test('should return audio for wav extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'wav');
          expect(result, equals(FileType.audio));
        });

        test('should return audio for flac extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'flac');
          expect(result, equals(FileType.audio));
        });

        test('should return audio for m4a extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'm4a');
          expect(result, equals(FileType.audio));
        });

        test('should return audio for audio/mpeg MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'audio/mpeg');
          expect(result, equals(FileType.audio));
        });

        test('should return audio for audio/ogg MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'audio/ogg');
          expect(result, equals(FileType.audio));
        });
      });

      group('video types', () {
        test('should return video for mp4 extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'mp4');
          expect(result, equals(FileType.video));
        });

        test('should return video for avi extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'avi');
          expect(result, equals(FileType.video));
        });

        test('should return video for mov extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'mov');
          expect(result, equals(FileType.video));
        });

        test('should return video for mkv extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'mkv');
          expect(result, equals(FileType.video));
        });

        test('should return video for webm extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'webm');
          expect(result, equals(FileType.video));
        });

        test('should return video for video/mp4 MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'video/mp4');
          expect(result, equals(FileType.video));
        });

        test('should return video for video/quicktime MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'video/quicktime');
          expect(result, equals(FileType.video));
        });
      });

      group('document types', () {
        test('should return document for pdf extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'pdf');
          expect(result, equals(FileType.document));
        });

        test('should return document for doc extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'doc');
          expect(result, equals(FileType.document));
        });

        test('should return document for docx extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'docx');
          expect(result, equals(FileType.document));
        });

        test('should return document for txt extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'txt');
          expect(result, equals(FileType.document));
        });

        test('should return document for md extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'md');
          expect(result, equals(FileType.document));
        });

        test('should return document for application/pdf MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'application/pdf');
          expect(result, equals(FileType.document));
        });

        test('should return document for text/plain MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'text/plain');
          expect(result, equals(FileType.document));
        });
      });

      group('archive types', () {
        test('should return archive for zip extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'zip');
          expect(result, equals(FileType.archive));
        });

        test('should return archive for rar extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'rar');
          expect(result, equals(FileType.archive));
        });

        test('should return archive for tar extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'tar');
          expect(result, equals(FileType.archive));
        });

        test('should return archive for bz2 extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'bz2');
          expect(result, equals(FileType.archive));
        });

        test('should return archive for 7z extension', () {
          final result = FileType.fromExtensionOrMime(extension: '7z');
          expect(result, equals(FileType.archive));
        });

        test('should return archive for application/zip MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'application/zip');
          expect(result, equals(FileType.archive));
        });
      });

      group('url types', () {
        test('should return url for uri extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'uri');
          expect(result, equals(FileType.html));
        });

        test('should return url for text/uri-list MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'text/uri-list');
          expect(result, equals(FileType.html));
        });

        test('should return html for html extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'html');
          expect(result, equals(FileType.html));
        });

        test('should return html for htm extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'htm');
          expect(result, equals(FileType.html));
        });

        test('should return html for text/html MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'text/html');
          expect(result, equals(FileType.html));
        });

        test('should return html for xhtml extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'xhtml');
          expect(result, equals(FileType.html));
        });

        test('should return html for application/xhtml+xml MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'application/xhtml+xml');
          expect(result, equals(FileType.html));
        });
      });

      group('other types', () {
        test('should return other for unknown extension', () {
          final result = FileType.fromExtensionOrMime(extension: 'unknown');
          expect(result, equals(FileType.other));
        });

        test('should return other for unknown MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: 'application/x-unknown');
          expect(result, equals(FileType.other));
        });

        test('should return other when both extension and mimeType are null', () {
          final result = FileType.fromExtensionOrMime();
          expect(result, equals(FileType.other));
        });
      });

      group('edge cases', () {
        test('should handle empty extension', () {
          final result = FileType.fromExtensionOrMime(extension: '');
          expect(result, equals(FileType.other));
        });

        test('should handle empty MIME type', () {
          final result = FileType.fromExtensionOrMime(mimeType: '');
          expect(result, equals(FileType.other));
        });

        test('should prefer extension over MIME type when both are provided', () {
          final result = FileType.fromExtensionOrMime(
            extension: 'jpg',
            mimeType: 'audio/mpeg',
          );
          expect(result, equals(FileType.image));
        });
      });
    });

    group('isAny', () {
      test('should return true when FileType is in the list', () {
        expect(FileType.image.isAny([FileType.image, FileType.audio]), isTrue);
      });

      test('should return false when FileType is not in the list', () {
        expect(FileType.image.isAny([FileType.audio, FileType.video]), isFalse);
      });

      test('should return false for empty list', () {
        expect(FileType.image.isAny([]), isFalse);
      });
    });

    group('isAnyType', () {
      test('should return true when type matches', () {
        expect(FileType.image.isAnyType([FileType]), isTrue);
      });

      test('should return false when type does not match', () {
        expect(FileType.image.isAnyType([String, int]), isFalse);
      });
    });

    group('equality', () {
      test('same FileType instances should be equal', () {
        expect(FileType.image, equals(FileType.image));
        expect(FileType.audio, equals(FileType.audio));
      });

      test('different FileType instances should not be equal', () {
        expect(FileType.image, isNot(equals(FileType.audio)));
        expect(FileType.video, isNot(equals(FileType.document)));
      });

      test('FileType created from extension should equal static instance', () {
        final fromExtension = FileType.fromExtensionOrMime(extension: 'jpg');
        expect(fromExtension, equals(FileType.image));
      });

      test('FileType created from MIME type should equal static instance', () {
        final fromMime = FileType.fromExtensionOrMime(mimeType: 'image/jpeg');
        expect(fromMime, equals(FileType.image));
      });
    });

    group('values', () {
      test('should contain all FileType instances', () {
        expect(FileType.values.length, equals(7));
        expect(FileType.values, contains(FileType.image));
        expect(FileType.values, contains(FileType.audio));
        expect(FileType.values, contains(FileType.video));
        expect(FileType.values, contains(FileType.document));
        expect(FileType.values, contains(FileType.html));
        expect(FileType.values, contains(FileType.archive));
        expect(FileType.values, contains(FileType.other));
      });
    });

    group('fromPath', () {
      test('should detect file type from path extension', () {
        final result = FileType.fromPath('test.jpg');
        expect(result, equals(FileType.image));
      });

      test('should use provided mimeType when available', () {
        final result = FileType.fromPath('test.unknown', 'image/png');
        expect(result, equals(FileType.image));
      });

      test('should detect file type from path for various extensions', () {
        expect(FileType.fromPath('test.mp3'), equals(FileType.audio));
        expect(FileType.fromPath('test.mp4'), equals(FileType.video));
        expect(FileType.fromPath('test.pdf'), equals(FileType.document));
        expect(FileType.fromPath('test.zip'), equals(FileType.archive));
      });
    });

    group('fromBytes', () {
      test('should use provided mimeType when available', () async {
        final file = Fixture.sample_image;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes, file.mimeType);
        expect(result, equals(FileType.image));
      });

      test('should return other for unknown bytes', () async {
        final unknownBytes = Fixture.sample_unknown_file;
        final result = FileType.fromBytes(await unknownBytes.readAsBytes());
        expect(result, equals(FileType.other));
      });
    });

    group('asset files', () {
      test('should detect MP3 audio file from path', () async {
        final result = FileType.fromPath(Fixture.pathes.sample_audio);
        expect(result, equals(FileType.audio));
      });

      test('should detect MP3 audio file from bytes', () async {
        final file = Fixture.sample_audio;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes);
        expect(result, equals(FileType.audio));
      });
      test('should detect MP3 audio file from bytes', () async {
        final file = Fixture.sample_audio;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes, 'audio/mpeg');
        expect(result, equals(FileType.audio));
      });

      test('should detect JPG image file from path (uppercase extension)', () {
        final result = FileType.fromPath(Fixture.pathes.sample_image.toUpperCase());
        expect(result, equals(FileType.image));
      });

      test('should detect JPG image file from bytes (uppercase)', () async {
        final file = Fixture.sample_image;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes);
        expect(result, equals(FileType.image));
      });

      test('should detect PDF document file from path', () {
        final result = FileType.fromPath(Fixture.pathes.sample_document);
        expect(result, equals(FileType.document));
      });

      test('should detect PDF document file from bytes', () async {
        final file = Fixture.sample_document;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes);
        expect(result, equals(FileType.document));
      });

      test('should detect MP4 video file from path', () {
        final path = Fixture.pathes.sample_video;
        final result = FileType.fromPath(path);
        expect(result, equals(FileType.video));
      });

      test('should detect MP4 video file from bytes', () async {
        final file = Fixture.sample_video;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes);
        expect(result, equals(FileType.video));
      });

      test('should detect jpg image file from path (lowercase)', () {
        final path = Fixture.pathes.sample_image;
        final result = FileType.fromPath(path);
        expect(result, equals(FileType.image));
      });

      test('should detect jpg image file from bytes (lowercase)', () async {
        final file = Fixture.sample_image;
        final bytes = await file.readAsBytes();
        final result = FileType.fromBytes(bytes);
        expect(result, equals(FileType.image));
      });
    });
  });
}
