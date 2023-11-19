part of 'visitors_bloc.dart';

final class VisitorsEvent {
  final List<Visitor> visitors;
  final bool hasReachedMax;

  VisitorsEvent({
    required this.visitors,
    required this.hasReachedMax,
  });

  VisitorsEvent copyWith({
    List<Visitor>? visitors,
    bool? hasReachedMax,
  }) {
    return VisitorsEvent(
      visitors: visitors ?? this.visitors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
