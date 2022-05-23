import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';
import 'package:path_provider/path_provider.dart';

/// An implementation of [OpusFlutterPlatform] for MacOS.
class OpusFlutterMacOS extends OpusFlutterPlatform {
  static const String _licenseFile = 'opus_license.txt';

  static Future<String> _copyFiles() async {
    String tmpPath = (await getTemporaryDirectory()).absolute.path;
    Directory dir =
        new Directory('$tmpPath/opus_flutter_macos/opus').absolute;
    await dir.create(recursive: true);

    ByteData data;
    File f = new File('${dir.path}/$_licenseFile');
    if (!(await f.exists())) {
      data = await rootBundle
          .load('packages/opus_flutter_macos/assets/$_licenseFile');
      await f.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    }

    String src = 'libopus.dylib.blob';
    String dst = 'libopus.dylib';
    // TODO: Handle aarch64 and x64
    // if (Platform.version.contains('x64')) {
    //   src = 'libopus_x64.dll.blob';
    //   dst = 'libopus_x64.dll';
    // } else {
    //   src = 'libopus_x86.dll.blob';
    //   dst = 'libopus_x86.dll';
    // }

    f = new File('${dir.path}/$dst');
    if (!(await f.exists())) {
      data = await rootBundle.load('packages/opus_flutter_macos/assets/$src');
      await f.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    }
    return f.path;
  }

  /// Registers the MacOS implementation.
  static void registerWith() {
    OpusFlutterPlatform.instance = new OpusFlutterMacOS();
  }

  /// Opens the shared opus library included in this plugin.
  Future<dynamic> load() async {
    String libPath = await _copyFiles();
    return DynamicLibrary.open(libPath);
  }
}
