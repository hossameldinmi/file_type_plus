import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:file_type_plus/file_type_plus.dart';

/// Represents a categorized file type with detection capabilities.
///
/// [FileType] provides multiple methods to detect and classify files into
/// categories such as image, audio, video, document, HTML, archive, or other.
/// Detection can be performed using file extensions, MIME types, file paths,
/// URLs, or byte data (magic numbers).
///
/// Example:
/// ```dart
/// // Detect from extension
/// final imageType = FileType.fromExtensionOrMime(extension: 'jpg');
/// print(imageType.value); // 'image'
///
/// // Detect from path
/// final videoType = FileType.fromPath('movie.mp4');
/// print(videoType.value); // 'video'
///
/// // Check if type matches
/// if (imageType == FileType.image) {
///   print('This is an image file');
/// }
/// ```
class FileType extends Equatable {
  /// The category name of this file type.
  ///
  /// Possible values: 'image', 'audio', 'video', 'document', 'html', 'archive', 'other'
  final String value;

  /// A map of file extensions to MIME types for this category.
  ///
  /// Keys are file extensions without dots (e.g., 'jpg', 'mp3').
  /// Values are the corresponding MIME types (e.g., 'image/jpeg', 'audio/mpeg').
  final Map<String, String> extensionMap;

  /// Creates a FileType from an extension group filter.
  ///
  /// This constructor allows you to create FileType instances using predefined
  /// category filters. It's primarily used internally to create the static
  /// file type constants (image, audio, video, etc.), but can also be used
  /// to create custom file types or extend the FileType class.
  ///
  /// The [groupFilter] parameter defines the category and its extension mapping.
  /// Available filters include:
  /// - [ExtensionGroupFilter.image] - Image files
  /// - [ExtensionGroupFilter.audio] - Audio files
  /// - [ExtensionGroupFilter.video] - Video files
  /// - [ExtensionGroupFilter.document] - Document files
  /// - [ExtensionGroupFilter.html] - HTML files
  /// - [ExtensionGroupFilter.archive] - Archive files
  /// - [ExtensionGroupFilter.other] - Other/unknown files
  ///
  /// Example:
  /// ```dart
  /// // Create a FileType instance using a filter
  /// final imageType = FileType(ExtensionGroupFilter.image);
  /// print(imageType.value); // 'image'
  ///
  /// // Use in a custom class
  /// class CustomFileType extends FileType {
  ///   final String customProperty;
  ///
  ///   CustomFileType(ExtensionGroupFilter filter, this.customProperty)
  ///       : super(filter);
  /// }
  /// ```
  ///
  /// See also:
  /// - [FileType.copy] for creating a FileType from another FileType instance
  /// - [FileType.fromExtensionOrMime] for detecting file types from extensions or MIME types
  FileType(ExtensionGroupFilter groupFilter)
      : value = groupFilter.name,
        extensionMap = ExtensionsGrouping.categorizedExtensions[groupFilter.name]!;

  /// Creates a FileType from another FileType enum value.
  ///
  /// [value] - The FileType enum value to copy.
  FileType.copy(FileType value)
      : value = value.value,
        extensionMap = value.extensionMap;

  /// Checks if this file type matches any type in the provided list.
  ///
  /// Returns `true` if this file type's value matches any of the types in [list].
  ///
  /// Example:
  /// ```dart
  /// final type = FileType.fromExtensionOrMime(extension: 'jpg');
  /// if (type.isAny([FileType.image, FileType.video])) {
  ///   print('This is a media file');
  /// }
  /// ```
  bool isAny(List<FileType> list) => list.map((e) => e.value).contains(value);

  /// Checks if this file type's runtime type matches any type in the provided list.
  ///
  /// This is a utility method for type checking.
  ///
  /// Returns `true` if this object's runtime type is in [list].
  bool isAnyType(List<Type> list) => list.contains(runtimeType);

  /// Image file type (jpg, png, gif, svg, webp, bmp, ico, etc.).
  static final image = FileType(ExtensionGroupFilter.image);

  /// Audio file type (mp3, wav, flac, aac, ogg, m4a, etc.).
  static final audio = FileType(ExtensionGroupFilter.audio);

  /// Video file type (mp4, avi, mov, webm, mkv, flv, m3u8, etc.).
  static final video = FileType(ExtensionGroupFilter.video);

  /// Document file type (pdf, doc, docx, txt, xls, xlsx, ppt, pptx, epub, etc.).
  static final document = FileType(ExtensionGroupFilter.document);

  /// HTML file type (html, htm, xhtml, xht).
  static final html = FileType(ExtensionGroupFilter.html);

  /// Archive file type (zip, rar, tar, gz, 7z, bz2, etc.).
  static final archive = FileType(ExtensionGroupFilter.archive);

  /// Fallback type for unrecognized or unclassified files.
  static final other = FileType(ExtensionGroupFilter.other);

  /// Creates a FileType from a file extension or MIME type.
  ///
  /// This method checks the extension and MIME type against known mappings
  /// to determine the file category. At least one parameter should be provided.
  ///
  /// Parameters:
  /// - [extension] - File extension without the dot (e.g., 'jpg', 'mp3').
  ///   Case-insensitive.
  /// - [mimeType] - MIME type string (e.g., 'image/jpeg', 'audio/mpeg').
  ///   Case-insensitive.
  ///
  /// Returns the matching [FileType], or [FileType.other] if no match is found.
  ///
  /// Example:
  /// ```dart
  /// final type1 = FileType.fromExtensionOrMime(extension: 'jpg');
  /// final type2 = FileType.fromExtensionOrMime(mimeType: 'image/jpeg');
  /// final type3 = FileType.fromExtensionOrMime(
  ///   extension: 'jpg',
  ///   mimeType: 'image/jpeg',
  /// );
  /// ```
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

  /// Creates a FileType from a file path or URL.
  ///
  /// Extracts the file extension from the path and determines the MIME type.
  /// Supports local file paths, Windows paths, and URLs (http, https, file).
  ///
  /// Special handling:
  /// - ISM streaming URLs (containing '.ism') are detected as video
  /// - Query parameters and fragments in URLs are handled
  ///
  /// Parameters:
  /// - [path] - The file path or URL to analyze.
  /// - [mimeType] - Optional explicit MIME type. If provided, it takes
  ///   precedence over path-based detection.
  ///
  /// Returns the detected [FileType], or [FileType.other] if detection fails.
  ///
  /// Example:
  /// ```dart
  /// final type1 = FileType.fromPath('photo.jpg');
  /// final type2 = FileType.fromPath('/home/user/video.mp4');
  /// final type3 = FileType.fromPath('https://example.com/image.png');
  /// final type4 = FileType.fromPath('C:\\Documents\\report.pdf');
  /// final type5 = FileType.fromPath('unknown.xyz', 'image/jpeg');
  /// ```
  factory FileType.fromPath(String path, [String? mimeType]) {
    final uri = Uri.parse(path);
    if (mimeType != null) return FileType.fromExtensionOrMime(mimeType: mimeType);
    mimeType = FileUtil.getMimeTypeFromPath(uri.path);
    return FileType.fromExtensionOrMime(mimeType: mimeType);
  }

  /// Creates a FileType from byte data using magic number detection.
  ///
  /// Analyzes the file's byte signature (magic numbers) to identify the file
  /// type. This is more reliable than extension-based detection as it examines
  /// the actual file content.
  ///
  /// Common magic numbers:
  /// - JPEG: FF D8 FF
  /// - PNG: 89 50 4E 47
  /// - PDF: 25 50 44 46
  /// - ZIP: 50 4B 03 04
  ///
  /// Parameters:
  /// - [bytes] - The byte data to analyze. Typically the first few bytes
  ///   of a file are sufficient for detection.
  /// - [mimeType] - Optional explicit MIME type. If provided, it takes
  ///   precedence over byte-based detection.
  ///
  /// Returns the detected [FileType], or [FileType.other] if the byte
  /// signature is not recognized.
  ///
  /// Example:
  /// ```dart
  /// final file = File('image.jpg');
  /// final bytes = file.readAsBytesSync();
  /// final type = FileType.fromBytes(bytes);
  ///
  /// // JPEG magic bytes
  /// final jpegBytes = Uint8List.fromList([0xFF, 0xD8, 0xFF]);
  /// final jpegType = FileType.fromBytes(jpegBytes);
  /// ```
  factory FileType.fromBytes(Uint8List bytes, [String? mimeType]) {
    if (mimeType != null) return FileType.fromExtensionOrMime(mimeType: mimeType);
    mimeType = FileUtil.getMimeTypeFromBytes(bytes);
    return FileType.fromExtensionOrMime(mimeType: mimeType);
  }

  /// Properties used for equality comparison.
  ///
  /// FileType instances are considered equal if they have the same [value].
  @override
  List<Object?> get props => [value];

  /// List of all available file type constants.
  ///
  /// Includes: image, audio, video, document, html, archive, and other.
  ///
  /// Useful for iterating over all file types:
  /// ```dart
  /// for (final type in FileType.values) {
  ///   print('${type.value}: ${type.extensionMap.length} extensions');
  /// }
  /// ```
  static final values = [image, audio, video, document, html, archive, other];
}
