import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/visitor.dart';

part 'visitors_event.dart';
part 'visitors_state.dart';

class VisitorsBloc extends Bloc<VisitorsEvent, VisitorsState> {
  VisitorsBloc() : super(VisitorsInitial()) {
    on<VisitorsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
