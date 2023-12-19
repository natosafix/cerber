part of 'event_detail_bloc.dart';

sealed class EventDetailEvent {}

final class DownloadDatabase extends EventDetailEvent {}

final class _DownloadStatusChanged extends EventDetailEvent {
  final DownloadStatus downloadStatus;

  _DownloadStatusChanged({required this.downloadStatus});
}
