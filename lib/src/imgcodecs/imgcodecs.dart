library cv.imgcodecs;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/constants.g.dart';
import '../g/imgcodecs.g.dart' as cimgcodecs;

/// IMRead reads an image from a file into a Mat.
/// The flags param is one of the IMReadFlag flags.
/// If the image cannot be read (because of missing file, improper permissions,
/// unsupported or invalid format), the function returns an empty Mat.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga288b8b3da0892bd651fce07b3bbd3a56
Mat imread(String filename, {int flags = IMREAD_COLOR}) {
  return cvRunArena<Mat>((arena) {
    final p = calloc<cimgcodecs.Mat>();
    cvRun(() => cimgcodecs.Image_IMRead(filename.toNativeUtf8(allocator: arena).cast(), flags, p));
    return Mat.fromPointer(p);
  });
}

/// IMWrite writes a Mat to an image file.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#gabbc7ef1aa2edfaa87772f1202d67e0ce
bool imwrite(String filename, InputArray img, {VecI32? params}) {
  return using<bool>((arena) {
    final fname = filename.toNativeUtf8(allocator: arena);
    final p = arena<ffi.Bool>();
    if (params == null) {
      cvRun(() => cimgcodecs.Image_IMWrite(fname.cast(), img.ref, p));
    } else {
      cvRun(
        () => cimgcodecs.Image_IMWrite_WithParams(
          fname.cast(),
          img.ref,
          params.ref,
          p,
        ),
      );
    }
    return p.value;
  });
}

/// IMEncode encodes an image Mat into a memory buffer.
/// This function compresses the image and stores it in the returned memory buffer,
/// using the image format passed in in the form of a file extension string.
///
/// For further details, please see:
/// http://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga461f9ac09887e47797a54567df3b8b63
(bool, Uint8List) imencode(
  String ext,
  InputArray img, {
  VecI32? params,
}) {
  final buffer = calloc<cimgcodecs.VecUChar>();
  final pSuccess = calloc<ffi.Bool>();
  final cExt = ext.toNativeUtf8().cast<ffi.Char>();

  params == null
      ? cvRun(() => cimgcodecs.Image_IMEncode(cExt, img.ref, pSuccess, buffer))
      : cvRun(() => cimgcodecs.Image_IMEncode_WithParams(cExt, img.ref, params.ref, pSuccess, buffer));
  final success = pSuccess.value;
  calloc.free(cExt);
  calloc.free(pSuccess);

  final vec = VecUChar.fromPointer(buffer);
  final u8List = vec.toU8List(); // will copy data
  vec.dispose();
  return (success, u8List);
}

/// imdecode reads an image from a buffer in memory.
/// The function imdecode reads an image from the specified buffer in memory.
/// If the buffer is too short or contains invalid data, the function
/// returns an empty matrix.
/// @param buf Input array or vector of bytes.
/// @param flags The same flags as in cv::imread, see cv::ImreadModes.
/// For further details, please see:
/// https://docs.opencv.org/master/d4/da8/group__imgcodecs.html#ga26a67788faa58ade337f8d28ba0eb19e
Mat imdecode(Uint8List buf, int flags, {Mat? dst}) {
  final vec = VecUChar.fromList(buf);
  print(vec.length);
  dst ??= Mat.empty();
  cvRun(() => cimgcodecs.Image_IMDecode(vec.ref, flags, dst!.ptr));
  return dst;
}
