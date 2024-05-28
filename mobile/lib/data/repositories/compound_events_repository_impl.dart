import 'dart:async';

import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/filled_answer.dart';
import 'package:project/domain/models/qr_code_data.dart';
import 'package:project/domain/models/question.dart';
import 'package:project/domain/models/ticket.dart';
import 'package:project/domain/models/visitor.dart';
import 'package:project/domain/repositories/compound_events_repository/compound_events_repository.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';
import 'package:project/domain/repositories/compound_events_repository/qr_code_process_result.dart';
import 'package:project/domain/repositories/events_repository.dart';
import 'package:project/domain/repositories/local_events_repository.dart';
import 'package:project/domain/repositories/remote_events_repository.dart';
import 'package:project/utils/cryptor/cryptor.dart';
import 'package:project/utils/network_checker/network_checker.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/result.dart';

class CompoundEventsRepositoryImpl implements CompoundEventsRepository {
  CompoundEventsRepositoryImpl({
    required this.remoteEventsRepository,
    required this.localEventsRepository,
  });

  @override
  final RemoteEventsRepository remoteEventsRepository;

  @override
  final LocalEventsRepository localEventsRepository;

  final _networkChecker = locator<NetworkChecker>();
  final _cryptor = locator<Cryptor>();

  final Set<int> _downloadedEventsIds = {};

  void _deleteNonexistentEvents() async {
    final savedEventsIds = (await localEventsRepository.getAllEventsIds()).toSet();

    final nonExistentEventsIds = savedEventsIds.difference(_downloadedEventsIds);

    localEventsRepository.deleteEventsByIds(nonExistentEventsIds.toList());

    _downloadedEventsIds.clear();
  }

  Future<bool> _networkAvailable() async {
    return await _networkChecker.networkAvailable();
  }

  @override
  Future<Result<List<Event>, Exception>> getEvents({
    required int offset,
    required int limit,
  }) async {
    if (!(await _networkAvailable())) {
      return await localEventsRepository.getEvents(offset: offset, limit: limit);
    }

    final result = await remoteEventsRepository.getEvents(
      offset: offset,
      limit: limit,
    );

    if (result.isSuccess) {
      final events = result.success;

      localEventsRepository.saveEvents(events);
      _downloadedEventsIds.addAll(events.map((e) => e.id));

      if (events.length < limit) {
        // local db stores all events that have ever been received from the api
        // it also includes events that were deleted on the frontend
        // thus in order to avoid showing them while offline they need to be removed
        // we do this after we have received all existing events from the api
        _deleteNonexistentEvents();
      }
    }

    return result;
  }

  @override
  Future<Visitor?> findVisitor(String visitorId, int eventId) async {
    if (await _networkAvailable()) {
      return await remoteEventsRepository.findVisitor(visitorId, eventId);
    }

    return await localEventsRepository.findVisitor(visitorId, eventId);
  }

  @override
  Future<void> downloadDatabase(int eventId, StreamSink<DownloadStatus> status) async {
    status.add(DownloadStatus.inProcess);

    final visitorsResult = await remoteEventsRepository.getVisitors(eventId);

    if (visitorsResult.isFailure) {
      return status.add(DownloadStatus.failure);
    }

    final visitors = visitorsResult.success;

    await localEventsRepository.deleteVisitors(eventId);
    await localEventsRepository.saveVisitors(visitors, eventId);

    final getQuestionsResult = await remoteEventsRepository.getQuestions(eventId);

    if (getQuestionsResult.isFailure) {
      return status.add(DownloadStatus.failure);
    }

    await localEventsRepository.deleteQuestions(eventId);
    await localEventsRepository.saveQuestions(getQuestionsResult.success, eventId);

    final tickets = await remoteEventsRepository.getTickets(eventId);

    if (tickets == null) {
      return status.add(DownloadStatus.failure);
    }

    await localEventsRepository.deleteTickets(eventId);
    await localEventsRepository.saveTickets(tickets, eventId);

    status.add(DownloadStatus.success);
  }

  @override
  Future<Result<List<Question>, Exception>> getQuestions(int eventId) async {
    if (await _networkAvailable()) {
      return await remoteEventsRepository.getQuestions(eventId);
    }

    return await localEventsRepository.getQuestions(eventId);
  }

  @override
  Future<QrCodeProcessResult> processQrCode(QrCodeData qrCodeData, Event event) async {
    final visitorIdDecrypted = _cryptor.decrypt(qrCodeData.encryptedVisitorId, event.cryptoKey, qrCodeData.iv);
    if (visitorIdDecrypted == null) return VisitorNotFound();

    final visitor = await findVisitor(visitorIdDecrypted, event.id);
    if (visitor == null) return VisitorIdValidButNotFound();

    localEventsRepository.setVisitorQrCodeScanned(visitor.id, event.id);

    return VisitorFound(visitor);
  }

  @override
  Future<QrCodeData> generateQrCode(Event event, List<FilledAnswer> filledAnswers, int ticketId) async {
    final newVisitorId = await addNewVisitorAnswers(ticketId, filledAnswers, event.id);

    final encryptResult = _cryptor.encrypt(newVisitorId!, event.cryptoKey);

    return QrCodeData(
      iv: encryptResult.iv,
      encryptedVisitorId: encryptResult.encrypted,
    );
  }

  @override
  Future<List<Ticket>?> getTickets(int eventId) async {
    if (await _networkAvailable()) {
      return await remoteEventsRepository.getTickets(eventId);
    }

    return await localEventsRepository.getTickets(eventId);
  }

  @override
  Future<NewVisitorId?> addNewVisitorAnswers(
    int ticketId,
    List<FilledAnswer> filledAnswers,
    int eventId,
  ) async {
    if (await _networkAvailable()) {
      final id = await remoteEventsRepository.addNewVisitorAnswers(ticketId, filledAnswers, eventId);
      if (id != null) return id;
    }

    return await localEventsRepository.addNewVisitorAnswers(ticketId, filledAnswers, eventId);
  }
}
