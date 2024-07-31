// ignore_for_file: constant_identifier_names

library cv.objdetect;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/objdetect.g.dart' as cobjdetect;

class CascadeClassifier extends CvStruct<cobjdetect.CascadeClassifier> {
  CascadeClassifier._(cobjdetect.CascadeClassifierPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory CascadeClassifier.fromPointer(
    cobjdetect.CascadeClassifierPtr ptr, [
    bool attach = true,
  ]) =>
      CascadeClassifier._(ptr, attach);

  factory CascadeClassifier.empty() {
    final p = calloc<cobjdetect.CascadeClassifier>();
    cvRun(() => cobjdetect.CascadeClassifier_New(p));
    return CascadeClassifier._(p);
  }

  factory CascadeClassifier.fromFile(String filename) {
    final p = calloc<cobjdetect.CascadeClassifier>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cobjdetect.CascadeClassifier_NewFromFile(cp, p));
    calloc.free(cp);
    return CascadeClassifier._(p);
  }

  /// Load cascade classifier from a file.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#a1a5884c8cc749422f9eb77c2471958bc
  bool load(String name) {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<ffi.Int>();
    cvRun(() => cobjdetect.CascadeClassifier_Load(ref, cname, p));
    calloc.free(cname);
    return p.value != 0;
  }

  /// DetectMultiScale detects objects of different sizes in the input Mat image.
  /// The detected objects are returned as a slice of image.Rectangle structs.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#aaf8181cb63968136476ec4204ffca498
  VecRect detectMultiScale(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) {
    final ret = calloc<cobjdetect.VecRect>();
    cvRun(
      () => cobjdetect.CascadeClassifier_DetectMultiScaleWithParams(
        ref,
        image.ref,
        ret,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
      ),
    );
    return VecRect.fromPointer(ret);
  }

  (VecRect objects, VecI32 numDetections) detectMultiScale2(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) {
    final ret = calloc<cobjdetect.VecRect>();
    final pnums = calloc<cobjdetect.VecI32>();
    cvRun(
      () => cobjdetect.CascadeClassifier_DetectMultiScale2(
        ref,
        image.ref,
        ret,
        pnums,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
      ),
    );
    return (VecRect.fromPointer(ret), VecI32.fromPointer(pnums));
  }

  (VecRect objects, VecI32 numDetections, VecF64 levelWeights) detectMultiScale3(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
    bool outputRejectLevels = false,
  }) {
    final objects = calloc<cobjdetect.VecRect>();
    final rejectLevels = calloc<cobjdetect.VecI32>();
    final levelWeights = calloc<cobjdetect.VecF64>();
    cvRun(
      () => cobjdetect.CascadeClassifier_DetectMultiScale3(
        ref,
        image.ref,
        objects,
        rejectLevels,
        levelWeights,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        outputRejectLevels,
      ),
    );
    return (VecRect.fromPointer(objects), VecI32.fromPointer(rejectLevels), VecF64.fromPointer(levelWeights));
  }

  /// Checks whether the classifier has been loaded.
  ///
  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a1753ebe58554fe0673ce46cb4e83f08a
  bool empty() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => cobjdetect.CascadeClassifier_Empty(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a0bab6de516c685ba879a4b1f1debdef1
  int getFeatureType() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cobjdetect.CascadeClassifier_getFeatureType(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a7a131d319ab42a444ff2bcbb433b7b41
  (int, int) getOriginalWindowSize() {
    final p = calloc<cobjdetect.Size>();
    cvRun(() => cobjdetect.CascadeClassifier_getOriginalWindowSize(ref, p));
    final ret = (p.ref.width, p.ref.height);
    calloc.free(p);
    return ret;
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a556bdd8738ba96aac07628ec38ff46da
  bool isOldFormatCascade() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => cobjdetect.CascadeClassifier_isOldFormatCascade(ref, p));
      return p.value;
    });
  }

  @override
  cobjdetect.CascadeClassifier get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cobjdetect.CascadeClassifierPtr>(cobjdetect.addresses.CascadeClassifier_Close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.CascadeClassifier_Close(ptr);
  }
}

class HOGDescriptor extends CvStruct<cobjdetect.HOGDescriptor> {
  HOGDescriptor._(cobjdetect.HOGDescriptorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory HOGDescriptor.fromPointer(
    cobjdetect.HOGDescriptorPtr ptr, [
    bool attach = true,
  ]) =>
      HOGDescriptor._(ptr, attach);

  factory HOGDescriptor.empty() {
    final p = calloc<cobjdetect.HOGDescriptor>();
    cvRun(() => cobjdetect.HOGDescriptor_New(p));
    return HOGDescriptor._(p);
  }

  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// Creates the HOG descriptor and detector and loads HOGDescriptor parameters and coefficients for the linear SVM classifier from a file.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a32a635936edaed1b2789caf3dcb09b6e
  factory HOGDescriptor.fromFile(String filename) {
    final p = calloc<cobjdetect.HOGDescriptor>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cobjdetect.HOGDescriptor_NewFromFile(cp, p));
    calloc.free(cp);
    return HOGDescriptor._(p);
  }

  bool load(String name) {
    return using<bool>((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      final p = arena<ffi.Bool>();
      cvRun(() => cobjdetect.HOGDescriptor_Load(ref, cname.cast(), p));
      return p.value;
    });
  }

  /// Computes HOG descriptors of given image.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a38cd712cd5a6d9ed0344731fcd121e8b
  (VecF32 descriptors, VecPoint locations) compute(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final descriptors = calloc<cobjdetect.VecF32>();
    final locations = calloc<cobjdetect.VecPoint>();
    cvRun(
      () => cobjdetect.HOGDescriptor_Compute(
        ref,
        img.ref,
        descriptors,
        winStride.cvd.ref,
        padding.cvd.ref,
        locations,
      ),
    );
    return (
      VecF32.fromPointer(descriptors),
      VecPoint.fromPointer(locations),
    );
  }

  /// Computes gradients and quantized gradient orientations.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a1f76c51c08d69f2b8a0f079efc4bd093
  (Mat grad, Mat angleOfs) computeGradient(
    InputArray img, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
  }) {
    final grad = Mat.empty();
    final angleOfs = Mat.empty();
    cvRun(
      () => cobjdetect.HOGDescriptor_computeGradient(
        ref,
        img.ref,
        grad.ref,
        angleOfs.ref,
        paddingTL.cvd.ref,
        paddingBR.cvd.ref,
      ),
    );
    return (grad, angleOfs);
  }

  /// Performs object detection without a multi-scale window.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a309829908ffaf4645755729d7aa90627
  (VecPoint foundLocations, VecF64 weights, VecPoint searchLocations) detect2(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = calloc<cobjdetect.VecPoint>();
    final searchLocations = calloc<cobjdetect.VecPoint>();
    final weights = calloc<cobjdetect.VecF64>();
    cvRun(
      () => cobjdetect.HOGDescriptor_Detect(
        ref,
        img.ref,
        foundLocations,
        weights,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations,
      ),
    );
    return (
      VecPoint.fromPointer(foundLocations),
      VecF64.fromPointer(weights),
      VecPoint.fromPointer(searchLocations),
    );
  }

  /// Performs object detection without a multi-scale window.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a309829908ffaf4645755729d7aa90627
  (VecPoint foundLocations, VecPoint searchLocations) detect(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = calloc<cobjdetect.VecPoint>();
    final searchLocations = calloc<cobjdetect.VecPoint>();
    cvRun(
      () => cobjdetect.HOGDescriptor_Detect2(
        ref,
        img.ref,
        foundLocations,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations,
      ),
    );
    return (VecPoint.fromPointer(foundLocations), VecPoint.fromPointer(searchLocations));
  }

  /// DetectMultiScale calls DetectMultiScale but allows setting parameters
  /// The detected objects are returned as a slice of image.Rectangle structs.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  VecRect detectMultiScale(
    InputArray image, {
    double hitThreshold = 0,
    int minNeighbors = 3,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
    double scale = 1.05,
    double groupThreshold = 2.0,
    bool useMeanshiftGrouping = false,
  }) {
    final rects = calloc<cobjdetect.VecRect>();
    cvRun(
      () => cobjdetect.HOGDescriptor_DetectMultiScaleWithParams(
        ref,
        image.ref,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        scale,
        groupThreshold,
        useMeanshiftGrouping,
        rects,
      ),
    );
    return VecRect.fromPointer(rects);
  }

  /// HOGDefaultPeopleDetector returns a new Mat with the HOG DefaultPeopleDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  static VecF32 getDefaultPeopleDetector() {
    final v = calloc<cobjdetect.VecF32>();
    cvRun(() => cobjdetect.HOG_GetDefaultPeopleDetector(v));
    return VecF32.fromPointer(v);
  }

  static VecF32 getDaimlerPeopleDetector() {
    final v = calloc<cobjdetect.VecF32>();
    cvRun(() => cobjdetect.HOGDescriptor_getDaimlerPeopleDetector(v));
    return VecF32.fromPointer(v);
  }

  int getDescriptorSize() {
    return using<int>((arena) {
      final p = arena<ffi.Size>(); // size_t
      cvRun(() => cobjdetect.HOGDescriptor_getDescriptorSize(ref, p));
      return p.value;
    });
  }

  /// Returns winSigma value.
  double getWinSigma() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cobjdetect.HOGDescriptor_getWinSigma(ref, p));
      return p.value;
    });
  }

  /// Groups the object candidate rectangles.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#ad7c9679b23e8476e332e9114181d656d
  (VecRect rectList, VecF64 weights) groupRectangles(
    VecRect rectList,
    VecF64 weights,
    int groupThreshold,
    double eps,
  ) {
    cvRun(
      () => cobjdetect.HOGDescriptor_groupRectangles(
        ref,
        rectList.ptr,
        weights.ptr,
        groupThreshold,
        eps,
      ),
    );
    rectList.reattach();
    weights.reattach();
    return (rectList, weights);
  }

  /// SetSVMDetector sets the data for the HOGDescriptor.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a09e354ad701f56f9c550dc0385dc36f1
  void setSVMDetector(VecF32 det) {
    cvRun(() => cobjdetect.HOGDescriptor_SetSVMDetector(ref, det.ref));
  }

  @override
  cobjdetect.HOGDescriptor get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cobjdetect.HOGDescriptorPtr>(cobjdetect.addresses.HOGDescriptor_Close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.HOGDescriptor_Close(ptr);
  }
}

// GroupRectangles groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/d5/d54/group__objdetect.html#ga3dba897ade8aa8227edda66508e16ab9
VecRect groupRectangles(VecRect rects, int groupThreshold, double eps) {
  cvRun(() => cobjdetect.GroupRectangles(rects.ptr, groupThreshold, eps));
  rects.reattach();
  return rects;
}

// QRCodeDetector groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html
class QRCodeDetector extends CvStruct<cobjdetect.QRCodeDetector> {
  QRCodeDetector._(cobjdetect.QRCodeDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory QRCodeDetector.fromPointer(
    cobjdetect.QRCodeDetectorPtr ptr, [
    bool attach = true,
  ]) =>
      QRCodeDetector._(ptr, attach);

  factory QRCodeDetector.empty() {
    final p = calloc<cobjdetect.QRCodeDetector>();
    cvRun(() => cobjdetect.QRCodeDetector_New(p));
    return QRCodeDetector._(p);
  }

  /// Decodes QR code on a curved surface in image once it's found by the detect() method.
  ///
  /// Returns UTF8-encoded output string or empty string if the code cannot be decoded.
  ///
  /// https://docs.opencv.org/4.x/de/dc3/classcv_1_1QRCodeDetector.html#ac7e9526c748b04186a6aa179f56096cf
  (String rval, Mat straightQRcode) decodeCurved(
    InputArray img,
    VecPoint points, {
    OutputArray? straightQRcode,
  }) {
    final s = straightQRcode?.ptr ?? calloc<cobjdetect.Mat>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cobjdetect.QRCodeDetector_decodeCurved(ref, img.ref, points.ref, s, v));
    final ss = v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (ss, Mat.fromPointer(s));
  }

  /// Both detects and decodes QR code on a curved surface.
  ///
  /// https://docs.opencv.org/4.x/de/dc3/classcv_1_1QRCodeDetector.html#a9166527f6e20b600ed6a53ab3dd61f51
  (String rval, VecPoint points, Mat straightQRcode) detectAndDecodeCurved(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
  }) {
    final p = points?.ptr ?? calloc<cobjdetect.VecPoint>();
    final s = straightQRcode?.ptr ?? calloc<cobjdetect.Mat>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cobjdetect.QRCodeDetector_detectAndDecodeCurved(ref, img.ref, p, s, v));
    final ss = v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (ss, points ?? VecPoint.fromPointer(p), Mat.fromPointer(s));
  }

  /// DetectAndDecode Both detects and decodes QR code.
  ///
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a7290bd6a5d59b14a37979c3a14fbf394
  (String ret, VecPoint points, Mat straightCode) detectAndDecode(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
  }) {
    final code = straightCode?.ptr ?? calloc<cobjdetect.Mat>();
    final points = calloc<cobjdetect.VecPoint>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => cobjdetect.QRCodeDetector_DetectAndDecode(ref, img.ref, points, code, v));
    final s = v == ffi.nullptr ? "" : v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (s, VecPoint.fromPointer(points), Mat.fromPointer(code));
  }

  /// Detect detects QR code in image and returns the quadrangle containing the code.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a64373f7d877d27473f64fe04bb57d22b
  (bool ret, VecPoint points) detect(InputArray input, {VecPoint? points}) {
    return cvRunArena<(bool, VecPoint)>((arena) {
      final pts = calloc<cobjdetect.VecPoint>();
      final ret = arena<ffi.Bool>();
      cvRun(() => cobjdetect.QRCodeDetector_Detect(ref, input.ref, pts, ret));
      return (ret.value, VecPoint.fromPointer(pts));
    });
  }

  /// Decode decodes QR code in image once it's found by the detect() method. Returns UTF8-encoded output string or empty string if the code cannot be decoded.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a4172c2eb4825c844fb1b0ae67202d329
  (String ret, VecPoint? points, Mat? straightCode) decode(
    InputArray img, {
    VecPoint? points,
    Mat? straightCode,
  }) {
    final p = points?.ptr ?? calloc<cobjdetect.VecPoint>();
    final ret = calloc<ffi.Pointer<ffi.Char>>();
    straightCode ??= Mat.empty();
    cvRun(() => cobjdetect.QRCodeDetector_Decode(ref, img.ref, p, straightCode!.ref, ret));
    final info = ret.value.cast<Utf8>().toDartString();
    calloc.free(ret);
    return (info, VecPoint.fromPointer(p), straightCode);
  }

  /// Detects QR codes in image and finds of the quadrangles containing the codes.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true if QR code was detected
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#aaf2b6b2115b8e8fbc9acf3a8f68872b6
  (bool, VecPoint points) detectMulti(InputArray img, {VecPoint? points}) {
    return cvRunArena<(bool, VecPoint)>((arena) {
      final p = points?.ptr ?? calloc<cobjdetect.VecPoint>();
      final ret = arena<ffi.Bool>();
      cvRun(() => cobjdetect.QRCodeDetector_DetectMulti(ref, img.ref, p, ret));
      return (ret.value, VecPoint.fromPointer(p));
    });
  }

  /// Detects QR codes in image, finds the quadrangles containing the codes, and decodes the QRCodes to strings.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a188b63ffa17922b2c65d8a0ab7b70775
  (bool, List<String>, VecPoint, VecMat) detectAndDecodeMulti(InputArray img) {
    final info = calloc<cobjdetect.VecVecChar>();
    final points = calloc<cobjdetect.VecPoint>();
    final codes = calloc<cobjdetect.VecMat>();
    final rval = calloc<ffi.Bool>();
    cvRun(() => cobjdetect.QRCodeDetector_DetectAndDecodeMulti(ref, img.ref, info, points, codes, rval));
    final ret = (
      rval.value,
      VecVecChar.fromPointer(info).asStringList(),
      VecPoint.fromPointer(points),
      VecMat.fromPointer(codes),
    );
    calloc.free(rval);
    return ret;
  }

  void setEpsX(double epsX) {
    cvRun(() => cobjdetect.QRCodeDetector_setEpsX(ref, epsX));
  }

  void setEpsY(double epsY) {
    cvRun(() => cobjdetect.QRCodeDetector_setEpsY(ref, epsY));
  }

  void setUseAlignmentMarkers(bool useAlignmentMarkers) {
    cvRun(() => cobjdetect.QRCodeDetector_setUseAlignmentMarkers(ref, useAlignmentMarkers));
  }

  static final finalizer = OcvFinalizer<cobjdetect.QRCodeDetectorPtr>(cobjdetect.addresses.QRCodeDetector_Close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.QRCodeDetector_Close(ptr);
  }

  @override
  cobjdetect.QRCodeDetector get ref => ptr.ref;
}

/// DNN-based face detector.
///
/// model download link: https://github.com/opencv/opencv_zoo/tree/master/models/face_detection_yunet
class FaceDetectorYN extends CvStruct<cobjdetect.FaceDetectorYN> {
  FaceDetectorYN._(cobjdetect.FaceDetectorYNPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FaceDetectorYN.fromPointer(
    cobjdetect.FaceDetectorYNPtr ptr, [
    bool attach = true,
  ]) =>
      FaceDetectorYN._(ptr, attach);

  /// Creates an instance of face detector class with given parameters.
  ///
  /// [model]	the path to the requested model
  ///
  /// [config]	the path to the config file for compability, which is not requested for ONNX models
  ///
  /// [inputSize]	the size of the input image
  ///
  /// [scoreThreshold]	the threshold to filter out bounding boxes of score smaller than the given value
  ///
  /// [nmsThreshold]	the threshold to suppress bounding boxes of IoU bigger than the given value
  ///
  /// [topK]	keep top K bboxes before NMS
  ///
  /// [backendId]	the id of backend
  ///
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a5f7fb43c60c95ca5ebab78483de02516
  factory FaceDetectorYN.fromFile(
    String model,
    String config,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cobjdetect.FaceDetectorYN>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => cobjdetect.FaceDetectorYN_New(
        cModel,
        cConfig,
        inputSize.cvd.ref,
        scoreThreshold,
        nmsThreshold,
        topK,
        backendId,
        targetId,
        p,
      ),
    );
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceDetectorYN._(p);
  }

  /// Creates an instance of face detector class with given parameters.
  ///
  /// [framework]	Name of origin framework
  ///
  /// [bufferModel]	A buffer with a content of binary file with weights
  ///
  /// [bufferConfig]	A buffer with a content of text file contains network configuration
  ///
  /// [inputSize]	the size of the input image
  ///
  /// [scoreThreshold]	the threshold to filter out bounding boxes of score smaller than the given value
  ///
  /// [nmsThreshold]	the threshold to suppress bounding boxes of IoU bigger than the given value
  ///
  /// [topK]	keep top K bboxes before NMS
  ///
  /// [backendId]	the id of backend
  ///
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#aa0796a4bfe2d4709bef81abbae9a927a
  factory FaceDetectorYN.fromBuffer(
    String framework,
    Uint8List bufferModel,
    Uint8List bufferConfig,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cobjdetect.FaceDetectorYN>();
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    cvRun(
      () => cobjdetect.FaceDetectorYN_NewFromBuffer(
        cFramework,
        bufM.ref,
        bufC.ref,
        inputSize.cvd.ref,
        scoreThreshold,
        nmsThreshold,
        topK,
        backendId,
        targetId,
        p,
      ),
    );
    calloc.free(cFramework);
    bufM.dispose();
    bufC.dispose();
    return FaceDetectorYN._(p);
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a68b6fb9bffbed0f3d5c104996113f247
  (int, int) getInputSize() {
    final p = calloc<cobjdetect.Size>();
    cvRun(() => cobjdetect.FaceDetectorYN_GetInputSize(ref, p));
    final ret = (p.ref.width, p.ref.height);
    calloc.free(p);
    return ret;
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a5329744e10441e1c01526f1ff10b80de
  double getScoreThreshold() {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cobjdetect.FaceDetectorYN_GetScoreThreshold(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a40749dc04b9578631d55122be9ab10c3
  double getNmsThreshold() {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cobjdetect.FaceDetectorYN_GetNMSThreshold(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#acc6139ba763acd67f4aa738cee45b7ec
  int getTopK() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cobjdetect.FaceDetectorYN_GetTopK(ref, p));
      return p.value;
    });
  }

  /// Detects faces in the input image. Following is an example output.
  ///
  /// [image]	an image to detect
  ///
  /// detection results stored in a 2D cv::Mat of shape [num_faces, 15]
  ///
  /// - 0-1: x, y of bbox top left corner
  /// - 2-3: width, height of bbox
  /// - 4-5: x, y of right eye (blue point in the example image)
  /// - 6-7: x, y of left eye (red point in the example image)
  /// - 8-9: x, y of nose tip (green point in the example image)
  /// - 10-11: x, y of right corner of mouth (pink point in the example image)
  /// - 12-13: x, y of left corner of mouth (yellow point in the example image)
  /// - 14: face score
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#ac05bd075ca3e6edc0e328927aae6f45b
  Mat detect(Mat image) {
    final p = calloc<cobjdetect.Mat>();
    cvRun(() => cobjdetect.FaceDetectorYN_Detect(ref, image.ref, p));
    return Mat.fromPointer(p);
  }

  /// Set the size for the network input, which overwrites the input size
  /// of creating model. Call this method when the size of input image does
  /// not match the input size when creating model.
  ///
  /// [inputSize]	the size of the input image
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a072418e5ce7beeb69c41edda75c41d2e
  void setInputSize((int, int) inputSize) {
    cvRun(() => cobjdetect.FaceDetectorYN_SetInputSize(ref, inputSize.cvd.ref));
  }

  /// Set the score threshold to filter out bounding boxes of score less than
  /// the given value.
  ///
  /// [scoreThreshold]	threshold for filtering out bounding boxes
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a37f3c23b82158fac7fdad967d315f85a
  void setScoreThreshold(double scoreThreshold) {
    cvRun(() => cobjdetect.FaceDetectorYN_SetScoreThreshold(ref, scoreThreshold));
  }

  /// Set the Non-maximum-suppression threshold to suppress
  /// bounding boxes that have IoU greater than the given value.
  ///
  /// [nmsThreshold]	threshold for NMS operation
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#ab6011efee7e12dca3857d82de5269ac5
  void setNMSThreshold(double nmsThreshold) {
    cvRun(() => cobjdetect.FaceDetectorYN_SetNMSThreshold(ref, nmsThreshold));
  }

  /// Set the number of bounding boxes preserved before NMS.
  ///
  /// [topK]	the number of bounding boxes to preserve from top rank based on score
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#aa88d20e1e2df75ea36b851534089856a
  void setTopK(int topK) {
    cvRun(() => cobjdetect.FaceDetectorYN_SetTopK(ref, topK));
  }

  @override
  cobjdetect.FaceDetectorYN get ref => ptr.ref;

  static final finalizer = OcvFinalizer<cobjdetect.FaceDetectorYNPtr>(cobjdetect.addresses.FaceDetectorYN_Close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.FaceDetectorYN_Close(ptr);
  }
}

/// DNN-based face recognizer.
///
/// model download link: https://github.com/opencv/opencv_zoo/tree/master/models/face_recognition_sface
class FaceRecognizerSF extends CvStruct<cobjdetect.FaceRecognizerSF> {
  FaceRecognizerSF._(cobjdetect.FaceRecognizerSFPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FaceRecognizerSF.fromPointer(cobjdetect.FaceRecognizerSFPtr ptr, [bool attach = true]) =>
      FaceRecognizerSF._(ptr, attach);

  /// Creates an instance of this class with given parameters.
  ///
  /// [model]	the path of the onnx model used for face recognition
  /// [config]	the path to the config file for compability, which is not requested for ONNX models
  /// [backendId]	the id of backend
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a04df90b0cd7d26d350acd92621a35743
  factory FaceRecognizerSF.fromFile(
    String model,
    String config, {
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cobjdetect.FaceRecognizerSF>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cobjdetect.FaceRecognizerSF_New(cModel, cConfig, backendId, targetId, p));
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceRecognizerSF._(p);
  }

  /// Aligns detected face with the source input image and crops it.
  ///
  /// [srcImg]	input image
  /// [faceBox]	the detected face result from the input image
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a84492908abecbc9362b4ddc8d46b8345
  Mat alignCrop(Mat srcImg, Mat faceBox) {
    final p = calloc<cobjdetect.Mat>();
    cvRun(() => cobjdetect.FaceRecognizerSF_AlignCrop(ref, srcImg.ref, faceBox.ref, p));
    return Mat.fromPointer(p);
  }

  /// Extracts face feature from aligned image.
  ///
  /// [alignedImg]	input aligned image
  /// [clone] the default implementation of opencv won't clone the returned Mat
  /// set [clone] to true will return a clone of returned Mat
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#ab1b4a3c12213e89091a490c573dc5aba
  Mat feature(Mat alignedImg, {bool clone = false}) {
    final p = calloc<cobjdetect.Mat>();
    cvRun(() => cobjdetect.FaceRecognizerSF_Feature(ref, alignedImg.ref, clone, p));
    return Mat.fromPointer(p);
  }

  /// Calculates the distance between two face features.
  ///
  /// [faceFeature1]	the first input feature
  /// [faceFeature2]	the second input feature of the same size and the same type as face_feature1
  /// [disType]	defines how to calculate the distance between two face features
  /// with optional values "FR_COSINE" or "FR_NORM_L2"
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a2f0362ca1e64320a1f3ba7e1386d0219
  double match(Mat faceFeature1, Mat faceFeature2, {int disType = FR_COSINE}) {
    return using<double>((arena) {
      final distance = arena<ffi.Double>();
      cvRun(
        () => cobjdetect.FaceRecognizerSF_Match(
          ref,
          faceFeature1.ref,
          faceFeature2.ref,
          disType,
          distance,
        ),
      );
      return distance.value;
    });
  }

  @override
  cobjdetect.FaceRecognizerSF get ref => ptr.ref;

  static final finalizer = OcvFinalizer<cobjdetect.FaceRecognizerSFPtr>(cobjdetect.addresses.FaceRecognizerSF_Close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.FaceRecognizerSF_Close(ptr);
  }

  @Deprecated("Use [FR_COSINE] instead.")
  static const int DIS_TYPR_FR_COSINE = 0;
  @Deprecated("Use [FR_NORM_L2] instead.")
  static const int DIS_TYPE_FR_NORM_L2 = 1;

  /// Definition of distance used for calculating the distance between two face features.
  static const int FR_COSINE = 0;

  /// Definition of distance used for calculating the distance between two face features.
  static const int FR_NORM_L2 = 1;
}
