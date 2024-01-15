part of 'event_detail_bloc.dart';

final class EventDetailState {
  final DownloadStatus downloadStatus;
  final DateTime? lastDownloaded;

  EventDetailState({
    required this.downloadStatus,
    required this.lastDownloaded,
  });

  bool get isDownloading => downloadStatus == DownloadStatus.inProcess;

  EventDetailState copyWith({
    DownloadStatus? downloadStatus,
    DateTime? lastDownloaded,
  }) {
    return EventDetailState(
      downloadStatus: downloadStatus ?? this.downloadStatus,
      lastDownloaded: lastDownloaded ?? this.lastDownloaded,
    );
  }
}
