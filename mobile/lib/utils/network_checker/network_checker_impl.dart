import 'dart:io';

import 'package:project/utils/network_checker/network_checker.dart';

class NetworkCheckerImpl implements NetworkChecker {
  static const _host = 'example.com';

  @override
  Future<bool> networkAvailable() async {
    try {
      final result = await InternetAddress.lookup(_host);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
