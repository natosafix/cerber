part of 'event_detail_bloc.dart';

final class EventDetailState {
  final DownloadStatus downloadStatus;
  final DateTime? lastDownloaded;
  final int generatedVisitorsCount;

  EventDetailState({
    required this.downloadStatus,
    required this.lastDownloaded,
    required this.generatedVisitorsCount,
  });

  bool get isDownloading => downloadStatus == DownloadStatus.inProcess;

  EventDetailState copyWith({
    DownloadStatus? downloadStatus,
    DateTime? lastDownloaded,
    int? generatedVisitorsCount,
  }) {
    return EventDetailState(
      downloadStatus: downloadStatus ?? this.downloadStatus,
      lastDownloaded: lastDownloaded ?? this.lastDownloaded,
      generatedVisitorsCount: generatedVisitorsCount ?? this.generatedVisitorsCount,
    );
  }
}
