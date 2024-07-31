// ignore_for_file: non_constant_identifier_names

library cv.dnn;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/mat_type.dart';
import '../core/rect.dart';
import '../core/scalar.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/dnn.g.dart' as cdnn;
import './dnn.dart';

extension LayerAsync on Layer {
  Future<int> inputNameToIndexAsync(String name) async {
    final cName = name.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<int>(
      (callback) => cdnn.Layer_InputNameToIndex_Async(ref, cName, callback),
      (c, p) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    calloc.free(cName);

    return rval;
  }

  Future<int> outputNameToIndexAsync(String name) async {
    final cName = name.toNativeUtf8().cast<ffi.Char>();
    final rval = cvRunAsync<int>(
      (callback) => cdnn.Layer_OutputNameToIndex_Async(ref, cName, callback),
      (c, p) {
        final rval = p.cast<ffi.Int>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    calloc.free(cName);
    return rval;
  }
}

extension NetAsync on Net {
  static Future<Net> emptyAsync() async {
    final rval = await cvRunAsync<Net>(cdnn.Net_Create_Async, (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });

    return rval;
  }

  static Future<Net> fromFileAsync(String path, {String config = "", String framework = ""}) async {
    final cPath = path.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNet_Async(cPath, cConfig, cFramework, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    calloc.free(cPath);
    calloc.free(cConfig);
    calloc.free(cFramework);

    return rval;
  }

  static Future<Net> fromBytesAsync(
    String framework,
    Uint8List bufferModel, {
    Uint8List? bufferConfig,
  }) async {
    bufferConfig ??= Uint8List(0);
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetBytes_Async(cFramework, bufM.ref, bufC.ref, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });

    calloc.free(cFramework);

    return rval;
  }

  static Future<Net> fromCaffeAsync(String prototxt, String caffeModel) async {
    final cProto = prototxt.toNativeUtf8().cast<ffi.Char>();
    final cCaffe = caffeModel.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetFromCaffe_Async(cProto, cCaffe, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    calloc.free(cProto);
    calloc.free(cCaffe);

    return rval;
  }

  static Future<Net> fromCaffeBytesAsync(Uint8List bufferProto, Uint8List bufferModel) async {
    final bufP = VecUChar.fromList(bufferProto);
    final bufM = VecUChar.fromList(bufferModel);
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetFromCaffeBytes_Async(bufP.ref, bufM.ref, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    return rval;
  }

  static Future<Net> fromOnnxAsync(String path) async {
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<Net>((callback) => cdnn.Net_ReadNetFromONNX_Async(cpath, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    calloc.free(cpath);

    return rval;
  }

  static Future<Net> fromOnnxBytesAsync(Uint8List bufferModel) async {
    final bufM = VecUChar.fromList(bufferModel);
    final rval =
        await cvRunAsync<Net>((callback) => cdnn.Net_ReadNetFromONNXBytes_Async(bufM.ref, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    return rval;
  }

  static Future<Net> fromTensorflowAsync(String path, {String config = ""}) async {
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final cconf = config.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetFromTensorflow_Async(cpath, cconf, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    calloc.free(cpath);
    calloc.free(cconf);

    return rval;
  }

  static Future<Net> fromTensorflowBytesAsync(Uint8List bufferModel, {Uint8List? bufferConfig}) async {
    bufferConfig ??= Uint8List(0);
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetFromTensorflowBytes_Async(bufM.ref, bufC.ref, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    return rval;
  }

  static Future<Net> fromTFLiteAsync(String path) async {
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final rval =
        await cvRunAsync<Net>((callback) => cdnn.Net_ReadNetFromTFLite_Async(cpath, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    calloc.free(cpath);
    return rval;
  }

  static Future<Net> fromTFLiteBytesAsync(Uint8List bufferModel) async {
    final bufM = VecUChar.fromList(bufferModel);
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetFromTFLiteBytes_Async(bufM.ref, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    return rval;
  }

  static Future<Net> fromTorchAsync(String path, {bool isBinary = true, bool evaluate = true}) async {
    final cpath = path.toNativeUtf8().cast<ffi.Char>();
    final rval = await cvRunAsync<Net>(
        (callback) => cdnn.Net_ReadNetFromTorch_Async(cpath, isBinary, evaluate, callback), (c, p) {
      return c.complete(Net.fromPointer(p.cast<cdnn.Net>()));
    });
    calloc.free(cpath);
    return rval;
  }

  Future<bool> isEmptyAsync() async {
    final rval = cvRunAsync<bool>(
      (callback) => cdnn.Net_Empty_Async(ref, callback),
      (c, p) {
        final rval = p.cast<ffi.Bool>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<String> dumpAsync() async {
    final rval = cvRunAsync<String>(
      (callback) => cdnn.Net_Dump_Async(ref, callback),
      (c, p) {
        final rval = p.cast<ffi.Pointer<ffi.Char>>().value.toDartString();
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<void> setInputAsync(InputArray blob, {String name = ""}) async {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    await cvRunAsync0<void>(
      (callback) => cdnn.Net_SetInput_Async(ref, blob.ref, cname, callback),
      (c) {
        return c.complete();
      },
    );
    calloc.free(cname);
  }

  Future<Mat> forwardAsync({String outputName = ""}) async {
    final rval = cvRunAsync<Mat>(
      (callback) => cdnn.Net_Forward_Async(ref, outputName.toNativeUtf8().cast<ffi.Char>(), callback),
      (c, result) => c.complete(Mat.fromPointer(result.cast<cdnn.Mat>())),
    );
    return rval;
  }

  Future<VecMat> forwardLayersAsync(List<String> names) async {
    final vecName = names.i8;
    final rval = cvRunAsync<VecMat>(
      (callback) => cdnn.Net_ForwardLayers_Async(ref, vecName.ref, callback),
      (c, result) => c.complete(VecMat.fromPointer(result.cast<cdnn.VecMat>())),
    );
    return rval;
  }

  Future<void> setPreferableBackendAsync(int backendId) async {
    await cvRunAsync0<void>(
      (callback) => cdnn.Net_SetPreferableBackend_Async(ref, backendId, callback),
      (c) => c.complete(),
    );
  }

  Future<void> setPreferableTargetAsync(int targetId) async {
    await cvRunAsync0<void>(
      (callback) => cdnn.Net_SetPreferableTarget_Async(ref, targetId, callback),
      (c) => c.complete(),
    );
  }

  Future<int> getPerfProfileAsync() async {
    final rval = cvRunAsync<int>(
      (callback) => cdnn.Net_GetPerfProfile_Async(ref, callback),
      (c, p) {
        final rval = p.cast<ffi.Int64>().value;
        calloc.free(p);
        return c.complete(rval);
      },
    );
    return rval;
  }

  Future<VecI32> getUnconnectedOutLayersAsync() async {
    final rval = cvRunAsync<VecI32>(
      (callback) => cdnn.Net_GetUnconnectedOutLayers_Async(ref, callback),
      (c, result) => c.complete(VecI32.fromPointer(result.cast<cdnn.VecI32>())),
    );
    return rval;
  }

  Future<List<String>> getLayerNamesAsync() async {
    final rval = cvRunAsync<List<String>>(
      (callback) => cdnn.Net_GetLayerNames_Async(ref, callback),
      (c, result) => c.complete(VecVecChar.fromPointer(result.cast<cdnn.VecVecChar>()).asStringList()),
    );
    return rval;
  }

  Future<(VecF32, VecI32)> getInputDetailsAsync() async {
    final rval = cvRunAsync2<(VecF32, VecI32)>(
      (callback) => cdnn.Net_GetInputDetails_Async(ref, callback),
      (c, sc, zp) => c.complete(
        (VecF32.fromPointer(sc.cast<cdnn.VecF32>()), VecI32.fromPointer(zp.cast<cdnn.VecI32>())),
      ),
    );
    return rval;
  }

  Future<Layer> getLayerAsync(int index) async {
    final rval = cvRunAsync<Layer>(
      (callback) => cdnn.Net_GetLayer_Async(ref, index, callback),
      (c, result) => c.complete(Layer.fromPointer(result.cast<cdnn.Layer>())),
    );
    return rval;
  }
}

Future<Mat> getBlobChannelAsync(Mat blob, int imgidx, int chnidx) async {
  final rval = cvRunAsync<Mat>(
    (callback) => cdnn.Net_GetBlobChannel_Async(blob.ref, imgidx, chnidx, callback),
    (c, result) => c.complete(Mat.fromPointer(result.cast<cdnn.Mat>())),
  );
  return rval;
}

Future<Scalar> getBlobSizeAsync(Mat blob) async {
  final rval = cvRunAsync<Scalar>(
    (callback) => cdnn.Net_GetBlobSize_Async(blob.ref, callback),
    (c, result) => c.complete(Scalar.fromPointer(result.cast<cdnn.Scalar>())),
  );
  return rval;
}

Future<List<int>> NMSBoxesAsync(
  VecRect bboxes,
  VecF32 scores,
  double scoreThreshold,
  double nmsThreshold, {
  double eta = 1.0,
  int topK = 0,
}) async {
  final rval = cvRunAsync<List<int>>(
    (callback) => cdnn.NMSBoxesWithParams_Async(
      bboxes.ref,
      scores.ref,
      scoreThreshold,
      nmsThreshold,
      eta,
      topK,
      callback,
    ),
    (c, result) => c.complete(VecI32.fromPointer(result.cast<cdnn.VecI32>()).toList()),
  );
  return rval;
}

Future<Mat> blobFromImageAsync(
  InputArray image, {
  double scalefactor = 1.0,
  (int, int) size = (0, 0),
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) async {
  mean ??= Scalar.zeros;
  final rval = await cvRunAsync<Mat>(
    (callback) => cdnn.Net_BlobFromImage_Async(
      image.ref,
      scalefactor,
      size.cvd.ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      callback,
    ),
    (c, mat) => c.complete(Mat.fromPointer(mat.cast<cdnn.Mat>())),
  );
  return rval;
}

Future<Mat> blobFromImagesAsync(
  VecMat images, {
  double scalefactor = 1.0,
  (int, int) size = (0, 0),
  Scalar? mean,
  bool swapRB = false,
  bool crop = false,
  int ddepth = MatType.CV_32F,
}) async {
  mean ??= Scalar.zeros;
  final rval = await cvRunAsync<Mat>(
    (callback) => cdnn.Net_BlobFromImages_Async(
      images.ref,
      scalefactor,
      size.cvd.ref,
      mean!.ref,
      swapRB,
      crop,
      ddepth,
      callback,
    ),
    (c, blob) => c.complete(Mat.fromPointer(blob.cast<cdnn.Mat>())),
  );
  return rval;
}

Future<List<Mat>> imagesFromBlobAsync(Mat blob) async {
  final rval = cvRunAsync<List<Mat>>(
    (callback) => cdnn.Net_ImagesFromBlob_Async(blob.ref, callback),
    (c, result) => c.complete(VecMat.fromPointer(result.cast<cdnn.VecMat>()).toList()),
  );
  return rval;
}
