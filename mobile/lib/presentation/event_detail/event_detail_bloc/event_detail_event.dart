part of 'event_detail_bloc.dart';

sealed class EventDetailEvent {}

final class DownloadDatabase extends EventDetailEvent {}

final class SyncGeneratedVisitors extends EventDetailEvent {}

final class _DownloadStatusChanged extends EventDetailEvent {
  final DownloadStatus downloadStatus;

  _DownloadStatusChanged(this.downloadStatus);
}

final class _EventChanged extends EventDetailEvent {
  final Event event;

  _EventChanged(this.event);
}

final class _GeneratedVisitorCountChanged extends EventDetailEvent {
  final int count;

  _GeneratedVisitorCountChanged(this.count);
}
