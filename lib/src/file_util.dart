import 'package:mime/mime.dart';

/// Utility class for MIME type detection from file paths and byte data.
///
/// This class provides static methods to determine MIME types using the
/// `mime` package. It serves as a wrapper around the `lookupMimeType`
/// function with specialized handling for different input types.
abstract class FileUtil {
  /// Determines the MIME type from a file path.
  ///
  /// Examines the file extension in the path and returns the corresponding
  /// MIME type. The path can be a local file path, URL, or any string
  /// containing a file extension.
  ///
  /// Parameters:
  /// - [path] - The file path or URL to analyze. Can include:
  ///   - Local paths: '/home/user/photo.jpg'
  ///   - URLs: 'https://example.com/image.png'
  ///   - Windows paths: 'C:\\Documents\\file.pdf'
  ///   - Relative paths: '../images/icon.svg'
  ///
  /// Returns the MIME type string (e.g., 'image/jpeg', 'application/pdf'),
  /// or `null` if the extension is not recognized.
  ///
  /// Example:
  /// ```dart
  /// final mime1 = FileUtil.getMimeTypeFromPath('photo.jpg');
  /// print(mime1); // 'image/jpeg'
  ///
  /// final mime2 = FileUtil.getMimeTypeFromPath('document.pdf');
  /// print(mime2); // 'application/pdf'
  ///
  /// final mime3 = FileUtil.getMimeTypeFromPath('unknown.xyz');
  /// print(mime3); // null
  /// ```
  static String? getMimeTypeFromPath(String path) => lookupMimeType(path);

  /// Determines the MIME type from byte data using magic number detection.
  ///
  /// Analyzes the file's byte signature (magic numbers) at the beginning
  /// of the data to identify the file type. This is more reliable than
  /// extension-based detection as it examines the actual file content.
  ///
  /// Common magic numbers:
  /// - JPEG: FF D8 FF
  /// - PNG: 89 50 4E 47 0D 0A 1A 0A
  /// - GIF: 47 49 46 38
  /// - PDF: 25 50 44 46
  /// - ZIP: 50 4B 03 04
  ///
  /// Parameters:
  /// - [bytes] - The byte data to analyze. Typically only the first
  ///   8-16 bytes are needed for most file formats, though providing
  ///   more data is safe and may improve accuracy.
  ///
  /// Returns the MIME type string (e.g., 'image/png', 'application/pdf'),
  /// or `null` if the byte signature is not recognized.
  ///
  /// Example:
  /// ```dart
  /// // Reading from a file
  /// final file = File('image.jpg');
  /// final bytes = file.readAsBytesSync();
  /// final mime = FileUtil.getMimeTypeFromBytes(bytes);
  /// print(mime); // 'image/jpeg'
  ///
  /// // From raw bytes (JPEG magic number)
  /// final jpegBytes = [0xFF, 0xD8, 0xFF, 0xE0];
  /// final jpegMime = FileUtil.getMimeTypeFromBytes(jpegBytes);
  /// print(jpegMime); // 'image/jpeg'
  ///
  /// // From unknown bytes
  /// final unknownBytes = [0x00, 0x00, 0x00, 0x00];
  /// final unknownMime = FileUtil.getMimeTypeFromBytes(unknownBytes);
  /// print(unknownMime); // null
  /// ```
  static String? getMimeTypeFromBytes(List<int> bytes) => lookupMimeType('test', headerBytes: bytes);
}
