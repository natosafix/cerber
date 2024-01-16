import 'dart:io';

import 'package:project/utils/constants/constants.dart';
import 'package:project/utils/network_checker/network_checker.dart';

class NetworkCheckerImpl implements NetworkChecker {
  @override
  Future<bool> networkAvailable() async {
    try {
      final result = await InternetAddress.lookup(Constants.eventsRepositoryBaseUrl);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
