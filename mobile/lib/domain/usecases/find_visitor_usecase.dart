import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/network_checker/network_checker.dart';

class FindVisitorUsecase {
  final _networkChecker = locator<NetworkChecker>();
  final _localEventsRepository = locator<LocalEventsRepository>();
  final _remoteEventsRepository = locator<RemoteEventsRepository>();

  Future<Visitor?> call({
    required String visitorId,
    required int eventId,
  }) async {
    if (await _networkChecker.networkAvailable()) {
      return await _remoteEventsRepository.findVisitor(visitorId, eventId);
    }

    return await _localEventsRepository.findVisitor(visitorId, eventId);
  }
}
